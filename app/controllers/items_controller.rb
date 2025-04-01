class ItemsController < ApplicationController
  before_action :require_admin
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "Item was successfully created."
      redirect_to items_path
    else
      flash.now[:error] = @item.errors.full_messages.to_sentence + "!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def toggle_active
    @item = Item.find(params[:id])
    @item.update(active: !@item.active) # Toggles true/false
    flash[:success] = "Status updated successfully."
    redirect_to items_path
  end

  private
  def item_params
    params.expect(item: [ :sku, :description, :base_price, :category, :active ])
  end
end
