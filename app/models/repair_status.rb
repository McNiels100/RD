class RepairStatus < ApplicationRecord
  belongs_to :repair
  belongs_to :status
  belongs_to :user, optional: true
  validates :repair, :status, presence: true
end
