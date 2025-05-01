  module SetDeviceData
    extend ActiveSupport::Concern

    private
    def set_device_data
      @devices = Device.all
      @brands = @devices.pluck(:brand).uniq
      @device_types = @devices.pluck(:device_type).uniq
    end
  end
