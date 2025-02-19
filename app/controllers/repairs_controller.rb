class RepairsController < ApplicationController
  def index
    @repairs = Repair.all
  end

  def show
    @repair = Repair.find(params[:id])
  end

  def new
    @repair = Repair.new
  end

  def create
    @repair = Repair.new(repair_params)
    if @repair.save
      redirect_to @repair
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def repair_params
    params.expect(repair: [ :name, :email, :phone_number, :brand, :error_description, :imei, :serial, :model ])
  end
end
