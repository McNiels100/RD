class Repair < ApplicationRecord
  validates :name, :email, :phone_number, :brand, :error_description, :model, presence: true
end
