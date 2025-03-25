class Status < ApplicationRecord
  validates :name, presence: true
  validates :active, inclusion: { in: [ true, false ] }
end
