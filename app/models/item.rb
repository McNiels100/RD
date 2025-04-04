class Item < ApplicationRecord
  validates :sku_prefix, uniqueness: true, presence: true
  validates :description, :base_price, :category, presence: true
  validates :active, inclusion: { in: [ true, false ] }

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  has_many :inventories, dependent: :destroy
end
