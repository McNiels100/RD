class InventoriesController < ApplicationController
  include SetDeviceData
  include Paginatable
  include Filterable

  before_action :require_admin_or_leader
  before_action :set_device_data, only: [ :index ]
  before_action :set_inventory, only: [ :show, :edit, :update, :destroy ]

  def index
    @inventories = Inventory.all
    @locations = @inventories.distinct.pluck(:location).sort

    # Apply the shared filters
    @inventories = filter_by_brands(@inventories)
    @inventories = filter_by_device_types(@inventories)
    @inventories = filter_by_locations(@inventories)

    # Apply inventory-specific filters
    if params[:inventory_statuses].present?
      @inventories = @inventories.where(status: params[:inventory_statuses])
    end

    # Paginate inventories
    @inventories = paginate(@inventories)
  end

  def show
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    if @inventory.save
      flash[:success] = "Inventory was successfully created."
      redirect_to new_inventory_path
    else
      flash.now[:error] = @inventory.errors.full_messages.to_sentence + "!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @inventory.update(inventory_params)
      redirect_to inventories_path
    else
      render :edit
    end
  end

  def destroy
    @inventory.destroy
    redirect_to inventories_path
  end

  private
  def inventory_params
    params.require(:inventory).permit(:imei, :serial, :location, :brand, :model, :model_code, :part_name)
  end

  def set_inventory
    @inventory = Inventory.find(params[:id])
  end
end
