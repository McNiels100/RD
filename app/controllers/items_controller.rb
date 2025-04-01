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

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "Item was successfully updated."
      redirect_to items_path
    else
      flash.now[:error] = @item.errors.full_messages.to_sentence + "!"
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle_active
    @item = Item.find(params[:id])
    @item.update(active: !@item.active) # Toggles true/false
    flash[:success] = "Status updated successfully."
    redirect_to items_path
  end

  private
  def item_params
    params.expect(item: [ :sku_prefix, :description, :base_price, :category, :active ])
  end
end
