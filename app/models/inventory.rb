class Inventory < ApplicationRecord
  include ImeiSerialValidation
  belongs_to :repair, optional: true
  validates :location, presence: true

  enum :status, {
    in_stock: 0,
    allocated_repair: 1,
    returned_to_stock: 2
  }

  validates :status, presence: true
end
