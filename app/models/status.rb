class Status < ApplicationRecord
  validates :name, presence: true
  validates :active, inclusion: { in: [ true, false ] }
  has_many :repair_statuses
  has_many :repairs, through: :repair_statuses

  scope :active, -> { where(active: true) }
end
