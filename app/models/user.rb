class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :allocations
  has_many :projects, through: :allocations

  # For admin check (add admin:boolean to users table if needed)
  def admin?
    self.admin
  end

  def total_allocated
    allocations.sum(:amount)
  end
end