class Item < ApplicationRecord
  validates :sku, uniqueness: true, presence: true
  validates :description, :base_price, :category, presence: true
  validates :active, inclusion: { in: [ true, false ] }

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
end
