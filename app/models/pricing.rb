class Pricing < ApplicationRecord
  validates :part_number, :price, :effective_date, presence: true
  validates :price, numericality: { greater_than: 0 }
  validate :no_whitespace_in_part_number

  def self.current_price_for(part_number)
    where(part_number: part_number)
      .order(effective_date: :desc)
      .first
  end

  private
  def no_whitespace_in_part_number
    if part_number.present? && (part_number != part_number.strip)
      errors.add(:part_number, "cannot contain leading or trailing whitespace")
    end
  end
end
