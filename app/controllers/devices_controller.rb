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


  def create
    @device = Device.new(repair_params)
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
  def repair_params
    params.expect(device: [ :brand, :device_type, :tat_neutral, :tat_unsatisfied, :tat_very_unsatisfied ])
  end
end
