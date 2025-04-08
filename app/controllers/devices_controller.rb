class DevicesController < ApplicationController
  before_action :require_admin
  def index
    @devices = Device.all
  end

  def new
    @device = Device.new
  end

  def show
    @device = Device.find(params[:id])
  end

  def edit
    @device = Device.find(params[:id])
  end

  def update
    @device = Device.find(params[:id])
    if @device.update(device_params)
      flash[:success] = "Device updated successfully!"
      redirect_to devices_path
    else
      flash.now[:error] = @device.errors.full_messages.to_sentence + "!"
      render :edit, status: :unprocessable_entity
    end
  end


  def create
    @device = Device.new(device_params)
    if @device.save
      redirect_to devices_path
    else
      flash.now[:error] = @device.errors.full_messages.to_sentence + "!"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @device = Device.find(params[:id])
    @device.destroy
    redirect_to devices_path
  end

  private
  def device_params
    params.require(:device).permit(:brand, :device_type, :tat_neutral, :tat_unsatisfied, :tat_very_unsatisfied)
  end
end
