class Inventory < ApplicationRecord
  include ImeiSerialValidation
  belongs_to :repair, optional: true
  validates :brand, :model_code, :location, :status, :part_number, presence: true

  enum :status, {
    in_stock: 0,
    allocated_repair: 1,
    returned_to_stock: 2,
    used: 3,
    reopened: 4
  }

  def current_price
     Pricing.current_price_for(part_number) if part_number.present?
   end
end
