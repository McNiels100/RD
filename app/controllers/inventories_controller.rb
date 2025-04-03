class InventoriesController < ApplicationController
  before_action :require_admin_or_leader

  def index
    @inventories = Inventory.all
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

  private
  def inventory_params
    params_with_defaults = params.require(:inventory).permit(:item_id, :location, :imei, :serial)

    # Find the associated item
    item = Item.find_by(id: params_with_defaults[:item_id])

    # Generate the full SKU with prefix if an item is selected
    if item.present?
      random_number = rand(10000).to_s.rjust(4, "0")  # Creates 4-digit number with leading zeros
      full_sku = "#{item.sku_prefix}-#{random_number}"
    else
      full_sku = nil  # Will trigger validation error since SKU is required
    end

    params_with_defaults.merge(
      created_by_user: current_user,
      sku: full_sku
    )
  end
end
