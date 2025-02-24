class Device < ApplicationRecord
  validates :brand, :device_type, :TAT_neutral, :TAT_unsatisfied, :TAT_very_unsatisfied, presence: true
end
