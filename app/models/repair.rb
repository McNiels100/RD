class Repair < ApplicationRecord
  before_create :generate_order_number
  validates :name, :email, :phone_number, :brand, :error_description, :model, presence: true

  private
  def generate_order_number
    last_order = Repair.lock.last
    self.order_number = last_order ? "RD-#{last_order.id + 1000}" : "RD-1000"
  end
end
