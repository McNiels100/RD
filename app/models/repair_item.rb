class RepairItem < ApplicationRecord
  belongs_to :repair
  belongs_to :inventory
  has_one :item, through: :inventory
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :repair, :inventory, :description, presence: true
end
