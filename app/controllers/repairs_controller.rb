class RepairsController < ApplicationController
  include Paginatable
  include TurboStreamRenderable
  include Filterable

  before_action :set_repair, only: [ :show, :edit, :update, :lock, :unlock, :add_status, :add_repair_item, :remove_repair_item ]
  before_action :set_device_data, only: [ :index, :new, :create, :show, :update, :reopen ]
  before_action :ensure_repair_not_completed, only: [ :edit, :update, :add_status, :add_repair_item, :remove_repair_item ]
  before_action :ensure_repair_locked_by_current_user, only: [ :edit, :update, :add_status, :add_repair_item, :remove_repair_item ]
  before_action :require_admin_or_leader, only: [ :reopen ]

  def index
    @repairs = Repair.all
    @devices = Device.all

    # Filters from filterable.rb concern
    @repairs = filter_by_search(@repairs)
    @repairs = filter_by_brands(@repairs)
    @repairs = filter_by_device_types(@repairs)
    @repairs = filter_by_repair_statuses(@repairs)
    @repairs = filter_by_tat_statuses(@repairs)

    # Paginate the filtered repairs
    @repairs = paginate(@repairs)
  end

  def show
    @device = Device.find_by(brand: @repair.brand, device_type: @repair.device_type)
    @repair_locked_by_current_user = @repair.locked_by?(current_user.email_address)
    @repair_items = @repair.repair_items.order(created_at: :desc)
  end

  def new
    @repair = Repair.new
  end

  def create
    @repair = Repair.new(repair_params)
    if @repair.save
      @repair.add_status(Status.find_by(name: "Received").id, current_user)
      flash[:success] = "Repair was successfully created."
      redirect_to @repair
    else
      flash.now[:error] = @repair.errors.full_messages.to_sentence + "!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @repair.update(repair_params)
      flash.now[:success] = "Repair was successfully updated."

      if params[:repair][:status_id].present?
        @repair.add_status(params[:repair][:status_id], current_user, params[:repair][:status_notes])
      end

      respond_to do |format|
        format.html { redirect_to repair_path(@repair) }
        format.turbo_stream { render_repair_information_stream }
      end

    else
    flash.now[:error] = @repair.errors.full_messages.to_sentence + "!"

      respond_to do |format|
        format.html { render :show, status: :unprocessable_entity }
        format.turbo_stream { render_repair_information_stream }
      end
    end
  end

  def lock
    if @repair.lock!(current_user.email_address)
      ActionCable.server.broadcast("repair_#{@repair.id}", { action: "lock", html: render_to_string(partial: "repair_lock", locals: { repair: @repair }) })
    end
    respond_to do |format|
      render_repair_lock_stream(@repair.id, { repair: @repair })
    end
  end

  def unlock
    if @repair.unlock!
      admin_email = current_user.email_address
      ActionCable.server.broadcast("repair_#{@repair.id}", { action: "unlock", html: render_to_string(partial: "repair_lock", locals: { repair: @repair, unlocked_by_admin: true, admin_email: admin_email }) })
    end
    respond_to do |format|
      format.turbo_stream { render_repair_lock_stream(@repair.id, { repair: @repair, unlocked_by_admin: true, admin_email: admin_email }) }
    end
  end

  def add_status
    @repair = Repair.find(params[:id])
    status_id = params[:repair][:status_id]
    notes = params[:repair][:status_notes]
    user = current_user

    if status_id.present?
      status = Status.find(status_id)

      if status.name == "Completed"
        @repair.mark_as_completed(user, notes)
        flash[:success] = "Repair marked as completed. All parts have been marked as used."
      else
        @repair.add_status(status_id, user, notes)
        flash.now[:success] = "Status updated successfully."
      end
    else
      flash.now[:error] = "Please select a status."
    end
    respond_to do |format|
      format.html { redirect_to repair_path(@repair) }
      # format.turbo_stream { render_status_history_stream }
    end
  end

  def reopen
    @repair = Repair.find(params[:id])

    if @repair.completed?
      @repair.mark_as_reopened(current_user)
      flash[:success] = "Repair has been re-opened successfully."
      redirect_to @repair
    else
      flash.now[:error] = "Only completed repairs can be re-opened."
    end
  end

  def add_repair_item
    if params[:part_names].present?
      selected_part_names = params[:part_names]
      added_parts = []
      no_longer_available_parts = []

      selected_part_names.each do |part_name|
        # Find first available inventory item with this part_name
        inventory_item = Inventory.where(
          repair_id: nil,
          model_code: @repair.model_code,
          part_name: part_name
        ).first

        if inventory_item
          @repair.add_repair_item(inventory_item.id)
          added_parts << part_name
        else
          # This part was available when the form was rendered but is now gone
          no_longer_available_parts << part_name
        end
      end

      # Create appropriate flash messages based on what happened
      if added_parts.any?
        flash.now[:success] = "Added parts: #{added_parts.join(', ')}"
      end

      if no_longer_available_parts.any?
        flash.now[:error] = "Could not add these parts (no longer available): #{no_longer_available_parts.join(', ')}"
      end

      if added_parts.empty? && no_longer_available_parts.empty?
        flash.now[:error] = "No parts were selected or available"
      end
    elsif params[:inventory].present?
      # Original logic for select dropdown but with added check
      inventory_id = params[:inventory]
      inventory_item = Inventory.find_by(id: inventory_id, repair_id: nil)

      if inventory_item
        @repair.add_repair_item(inventory_id)
        flash.now[:success] = "Repair item added successfully."
      else
        flash.now[:error] = "The selected part is no longer available."
      end
    else
      flash.now[:error] = "Please select parts to add."
    end

    respond_to do |format|
      format.html { redirect_to repair_path(@repair) }
      format.turbo_stream { render_repair_items_stream }
    end
  end

  def remove_repair_item
    repair_item = RepairItem.find(params[:item_id])

    if repair_item.present?
      @repair.remove_repair_item(repair_item)
      flash.now[:success] = "Repair item removed successfully."
    else
      flash.now[:error] = "Repair item not found."
    end
    respond_to do |format|
      format.html { redirect_to repair_path(@repair) }
      format.turbo_stream { render_repair_items_stream }
    end
  end

  def load_inventory
    @repair = Repair.find(params[:id])

    # Get ALL unique part names for this model, regardless of availability
    @all_part_names = Inventory.where(model_code: @repair.model_code)
                              .select(:part_name).distinct.pluck(:part_name).sort

    # Check availability for each part name
    @part_counts = {}
    @available_parts = {}

    @all_part_names.each do |part_name|
      count = Inventory.where(
        repair_id: nil,
        model_code: @repair.model_code,
        part_name: part_name
      ).count

      @part_counts[part_name] = count
      @available_parts[part_name] = count > 0
    end
  end

  private
  def set_repair
    @repair = Repair.find(params[:id])
  end

  def set_device_data
    @devices = Device.all
    @brands = @devices.pluck(:brand).uniq
    @device_types = @devices.pluck(:device_type).uniq
  end

  def ensure_repair_not_completed
    if @repair.completed?
      flash[:error] = "This repair is completed and cannot be edited."
      redirect_to @repair
    end
  end

  def repair_params
    params.require(:repair).permit(:name, :email, :phone_number, :brand, :device_type, :error_description, :imei, :serial, :model, :model_code)
  end

  def ensure_repair_locked_by_current_user
    unless @repair.locked_by?(current_user.email_address)
      flash[:error] = "You cannot edit this repair because it is not locked by you."
      redirect_to @repair
    end
  end
end
