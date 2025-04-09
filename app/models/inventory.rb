class Inventory < ApplicationRecord
  include ImeiSerialValidation
  belongs_to :repair, optional: true
  validates :location, presence: true

  enum :status, {
    in_stock: 0,
    allocated_repair: 1
  }

  validates :status, presence: true
end
