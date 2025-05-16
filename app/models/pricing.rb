class Pricing < ApplicationRecord
  validates :part_number, :price, :effective_date, presence: true
  validates :price, numericality: { greater_than: 0 }

  def self.current_price_for(part_number)
    where(part_number: part_number)
      .order(effective_date: :desc)
      .first
  end
end
