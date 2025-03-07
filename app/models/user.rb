class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # Check user roles
  ROLES = %w[admin leader technician].freeze

  validates :role, inclusion: { in: ROLES }

  def admin?
    role == "admin"
  end

  def leader?
    role == "leader"
  end

  def technician?
    role == "technician"
  end
end
