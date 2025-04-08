class Inventory < ApplicationRecord
  include ImeiSerialValidation
  belongs_to :repair, optional: true
  validates :location, presence: true
end
