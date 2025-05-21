class PricingsController < ApplicationController
  before_action :require_admin
  before_action :set_pricing, only: [ :destroy ]

  def index
    @pricings = Pricing.all
  end

  def new
    @pricing = Pricing.new
  end

  def create
    @pricing = Pricing.new(pricing_params)
    if @pricing.save
      flash[:success] = "Pricing was successfully created."
      redirect_to new_pricing_path
    else
      flash.now[:error] = @pricing.errors.full_messages.to_sentence + "!"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private
  def set_pricing
    @pricing = Pricing.find(params[:id])
  end

  def pricing_params
    params.require(:pricing).permit(:part_number, :price, :effective_date)
  end
end
