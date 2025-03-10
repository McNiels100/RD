class Repair < ApplicationRecord
  before_create :generate_order_number
  validates :name, :email, :phone_number, :brand, :error_description, :model, presence: true

  def lock(user)
    update(locked_by: user.email_address, locked_at: Time.current)
  end

  def unlock
    update(locked_by: nil, locked_at: nil)
  end

  def locked?
    locked_by.present? && locked_at.present?
  end

  private
  def generate_order_number
    last_order = Repair.lock.last
    self.order_number = last_order ? "RD-#{last_order.id + 1000}" : "RD-1000"
  end
end
