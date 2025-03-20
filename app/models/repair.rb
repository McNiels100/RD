class Repair < ApplicationRecord
  before_create :generate_order_number
  validates :name, :email, :phone_number, :brand, :device_type, :error_description, :model, presence: true
  validate :imei_or_serial_present

  # Lock the repair for a specific user (by email)
  def lock!(email)
    update(locked_by: email, locked_at: Time.current)
  end

  # Unlock the repair
  def unlock!
    update(locked_by: nil, locked_at: nil)
  end

  # Check if the repair is locked
  def locked?
    locked_by.present? && locked_at.present?
  end

  # Check if the repair is locked by a specific user
  def locked_by?(email)
    locked_by == email
  end

  # Check if the lock has expired (optional, e.g., after 10 minutes)
  def lock_expired?
    locked? && locked_at < 10.minutes.ago
  end

  # Generate a unique order number for the repair
  private
  def generate_order_number
    last_order = Repair.lock.last
    self.order_number = last_order ? "RD-#{last_order.id + 1000}" : "RD-1000"
  end

  def imei_or_serial_present
    if imei.blank? && serial.blank?
      errors.add(:base, "Either IMEI or Serial must be present")
    end
  end
end
