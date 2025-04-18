class RepairsController < ApplicationController
  before_action :set_repair, only: [ :show, :edit, :update, :lock, :unlock, :add_status, :add_repair_item, :remove_repair_item ]
  before_action :set_device_data, only: [ :index, :new, :create, :show ]
  before_action :ensure_repair_locked_by_current_user, only: [ :edit, :update, :add_status ]

  def index
    @repairs = Repair.all
    @devices = Device.all

    # Filter search by id
    @repairs = @repairs.where(order_number: "RD-" + params[:query]) if params[:search_in]=="order_number"

    # Filter search by phone
    @repairs = @repairs.where(phone_number: params[:query]) if params[:search_in]=="phone_number"

    # Filter search by email
    @repairs = @repairs.where(email: params[:query]) if params[:search_in]=="email"

    # Filter search by IMEI
    @repairs = @repairs.where(imei: params[:query]) if params[:search_in]=="imei"

    # Filter search by serial
    @repairs = @repairs.where(serial: params[:query]) if params[:search_in]=="serial"

    # Filter by selected brands
    if params[:brands].present?
      @repairs = @repairs.where(brand: params[:brands])
    end

    # Filter by device type
    if params[:device_types].present?
      @repairs = @repairs.where(device_type: params[:device_types])
    end

    # Filter by repair statuses
    if params[:repair_statuses].present?
      status_ids = Status.active.where(name: params[:repair_statuses]).pluck(:id)
      @repairs = @repairs.joins(:latest_status).where(statuses: { id: status_ids })
    end

    # Filter by TAT status
    if params[:tat_statuses].present?
      filtered_repairs = []
      @repairs.find_each do |repair|
        device = Device.find_by(brand: repair.brand, device_type: repair.device_type)
        if device
          status = helpers.determine_tat_status(device, repair.created_at)
          filtered_repairs << repair.id if params[:tat_statuses].include?(status)
        end
      end
      @repairs = Repair.where(id: filtered_repairs)
    end
  end

  def show
    @device = Device.find_by(brand: @repair.brand, device_type: @repair.device_type)
    @repair_locked_by_current_user = @repair.locked_by?(current_user.email_address)
    @repair_items = @repair.repair_items.order(created_at: :desc)
    @inventory = Inventory.new
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
      if params[:repair][:status_id].present?
        @repair.add_status(params[:repair][:status_id], current_user, params[:repair][:status_notes])
      end
      flash[:success] = "Repair was successfully updated."
      redirect_to @repair
    else
      flash.now[:error] = @repair.errors.full_messages.to_sentence + "!"
      render :show, status: :unprocessable_entity
    end
  end

  def lock
    if @repair.lock!(current_user.email_address)
      ActionCable.server.broadcast("repair_#{@repair.id}", { action: "lock", html: render_to_string(partial: "repair_lock", locals: { repair: @repair }) })
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("repair_#{@repair.id}", partial: "repair_lock", locals: { repair: @repair })
      end
    end
  end

  def unlock
    if @repair.unlock!
      admin_email = current_user.email_address # Assuming current_user contains the admin's email
      ActionCable.server.broadcast("repair_#{@repair.id}", { action: "unlock", html: render_to_string(partial: "repair_lock", locals: { repair: @repair, unlocked_by_admin: true, admin_email: admin_email }) })
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("repair_#{@repair.id}", partial: "repair_lock", locals: { repair: @repair, unlocked_by_admin: true, admin_email: admin_email })
      end
    end
  end

  def add_status
    @repair = Repair.find(params[:id])
    status_id = params[:repair][:status_id]
    notes = params[:repair][:status_notes]
    user = current_user

    if status_id.present?
      @repair.add_status(status_id, user, notes)
      flash[:success] = "Status updated successfully."
    else
      flash[:error] = "Please select a status."
    end
    respond_to do |format|
      format.html { redirect_to repair_path(@repair) }
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.replace("status_history_#{@repair.id}", partial: "status_history"),
          render_turbo_flash        ]
      }
    end
  end

  def add_repair_item
    inventory_id = params[:inventory]

    if inventory_id.present?
      @repair.add_repair_item(inventory_id)
      flash[:success] = "Repair item added successfully."
    else
      flash[:error] = "Please select an inventory item to use."
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
      flash[:success] = "Repair item removed successfully."
    else
      flash[:error] = "Repair item not found."
    end
    respond_to do |format|
      format.html { redirect_to repair_path(@repair) }
      format.turbo_stream { render_repair_items_stream }
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

  def repair_params
    params.require(:repair).permit(:name, :email, :phone_number, :brand, :device_type, :error_description, :imei, :serial, :model)
  end

  def ensure_repair_locked_by_current_user
    unless @repair.locked_by?(current_user.email_address)
      flash[:error] = "You cannot edit this repair because it is not locked by you."
      redirect_to @repair
    end
  end

  def render_turbo_flash
    turbo_stream.replace("flash", partial: "layouts/flash")
  end

  def render_repair_items_stream
    render turbo_stream: [
      turbo_stream.replace("repair_parts_#{@repair.id}",
                           partial: "parts",
                           locals: { repair: @repair,
                                     repair_items: @repair.repair_items.order(created_at: :desc) }),
      render_turbo_flash
    ]
  end
end
