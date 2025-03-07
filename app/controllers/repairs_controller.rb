class RepairsController < ApplicationController
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
  end

  def show
    @repair = Repair.find(params[:id])
    @device = Device.find_by(brand: @repair.brand, device_type: @repair.device_type)
  end

  def new
    @repair = Repair.new
    @devices = Device.all
    @brands = @devices.pluck(:brand).uniq
    @device_types = @devices.pluck(:device_type).uniq
  end

  def create
    @repair = Repair.new(repair_params)
    if @repair.save
      flash[:success] = "Repair was successfully created."
      redirect_to @repair
    else
      flash.now[:error] = @repair.errors.full_messages.to_sentence + "!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @repair = Repair.find(params[:id])
  end

  def update
    @repair = Repair.find(params[:id])
    if @repair.update(repair_params)
      flash[:success] = "Repair was successfully updated."
      redirect_to @repair
    else
      flash.now[:error] = @repair.errors.full_messages.to_sentence + "!"
      render :show, status: :unprocessable_entity
    end
  end

  private
  def repair_params
    params.expect(repair: [ :name, :email, :phone_number, :brand, :device_type, :error_description, :imei, :serial, :model ])
  end
end
