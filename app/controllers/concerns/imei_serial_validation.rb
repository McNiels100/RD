module ImeiSerialValidation
  extend ActiveSupport::Concern

  included do
    validate :imei_or_serial_present
  end

  private

  def imei_or_serial_present
    if imei.blank? && serial.blank?
      errors.add(:base, "Either IMEI or Serial must be present")
    end
  end
end
