class Inventory < ApplicationRecord
  include ImeiSerialValidation
  belongs_to :repair, optional: true
  validates :brand, :model_code, :location, :status, presence: true

  enum :status, {
    in_stock: 0,
    allocated_repair: 1,
    returned_to_stock: 2,
    used: 3
  }
end
