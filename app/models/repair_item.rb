class RepairItem < ApplicationRecord
  belongs_to :repair
  belongs_to :inventory
end
