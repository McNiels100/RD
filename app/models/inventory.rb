class Inventory < ApplicationRecord
  belongs_to :item
  belongs_to :used_by_user, class_name: "User", optional: true
  belongs_to :created_by_user, class_name: "User"
  belongs_to :repair, optional: true

  validates :location, presence: true
  validates :sku, presence: true, uniqueness: true
  validates :imei, uniqueness: { allow_nil: true }
  validates :serial, uniqueness: { allow_blank: true }

  enum status: {
     in_stock: "in_stock",
     allocated: "allocated",
     in_repair: "in_repair",
     used: "used",
     returned: "returned",
     defective: "defective"
  }

  # Track when an item is used in a repair
  def mark_used(repair, user)
    update!(
      repair: repair,
      used_by_user: user,
      used_at: Time.current,
      status: :used
    )
  end

  # Return to inventory
  def return_to_stock
    update!(
      repair: nil,
      used_by_user: nil,
      used_at: nil,
      status: :in_stock
    )
  end
end
