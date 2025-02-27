class Device < ApplicationRecord
  validates :brand, :device_type, :tat_neutral, :tat_unsatisfied, :tat_very_unsatisfied, presence: true
end
