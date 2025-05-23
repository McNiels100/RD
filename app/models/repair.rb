class Repair < ApplicationRecord
  include ImeiSerialValidation

  before_create :generate_order_number
  validates :name, :email, :phone_number, :brand, :device_type, :error_description, :model, presence: true

  has_many :repair_statuses, dependent: :destroy
  has_many :statuses, through: :repair_statuses

  has_one :latest_repair_status, -> { order(created_at: :desc) }, class_name: "RepairStatus"
  has_one :latest_status, through: :latest_repair_status, source: :status

  has_many :repair_items, dependent: :destroy

  has_many_attached :images

  # Returns the current status
  def current_status
    latest_status
  end

  # Add a new status to the repair
  def add_status(status_id, user = nil, notes = nil)
    status = Status.find(status_id)
    repair_statuses.create!(status: status, user: user, notes: notes)
  end

  # Checks if the repair is completed
  def completed?
    current_status&.name == "Completed"
  end

  # Closes the repair
  def mark_as_completed(user, notes = nil)
    ActiveRecord::Base.transaction do
      # Find the "Completed" status
      completed_status = Status.find_by(name: "Completed")

      # Add the completed status
      add_status(completed_status.id, user, notes)

      # Update all associated inventory items to "used"
      repair_items.each do |repair_item|
        repair_item.inventory.update!(status: :used)
      end

      # Unlock the repair if it was locked
      unlock! if locked?
    end
  end

  # Re-open repair
  def mark_as_reopened(user, notes = nil)
    ActiveRecord::Base.transaction do
      # Find the "Open" status
      open_status = Status.find_by(name: "Re-opened")

      # Add the open status
      add_status(open_status.id, user, notes)

      # Update all associated inventory items to "reopened"
      repair_items.each do |repair_item|
        repair_item.inventory.update!(status: :reopened)
      end
    end
  end

  # Add a new RepairItem to the repair
  def add_repair_item(inventory_id)
      inventory = Inventory.find(inventory_id)

      # Ensure the inventory item is actually available before trying to allocate it.
      unless inventory.in_stock? || inventory.returned_to_stock?
        errors.add(:base, "Inventory item is not in stock (Current status: #{inventory.status}). Cannot allocate.")
        return false
      end

      # Use a transaction to ensure both the inventory update and the repair item creation succeed or fail together.
      ActiveRecord::Base.transaction do
        inventory.update!(
          status: :allocated_repair,
          repair_id: self.id # self.id refers to the ID of the current Repair instance
        )

        description = "#{inventory.part_name} - #{inventory.brand} #{inventory.model}"
        imei = inventory.imei
        serial = inventory.serial
        current_pricing = inventory.current_price
        unit_price = current_pricing ? current_pricing.price : 0

         repair_items.create!(
           inventory: inventory,
           description: description,
           unit_price: unit_price,
           imei: imei,
           serial: serial
         )
      end
  end

  def remove_repair_item(repair_item)
    ActiveRecord::Base.transaction do
      inventory = repair_item.inventory
      repair_item.destroy!
      inventory.update!(status: :returned_to_stock, repair_id: nil)
    end
  end

  # Lock the repair for a specific user (by email)
  def lock!(email)
    update(locked_by: email, locked_at: Time.current)
  end

  # Unlock the repair
  def unlock!
    update(locked_by: nil, locked_at: nil)
  end

  # Check if the repair is locked
  def locked?
    locked_by.present? && locked_at.present?
  end

  # Check if the repair is locked by a specific user
  def locked_by?(email)
    locked_by == email
  end

  # Check if the lock has expired (optional, e.g., after 10 minutes)
  def lock_expired?
    locked? && locked_at < 10.minutes.ago
  end

  # Generate a unique order number for the repair
  private
  def generate_order_number
    last_order = Repair.lock.last
    self.order_number = last_order ? "RD-#{last_order.id + 1000}" : "RD-1000"
  end

  def imei_or_serial_present
    if imei.blank? && serial.blank?
      errors.add(:base, "Either IMEI or Serial must be present")
    end
  end
end
