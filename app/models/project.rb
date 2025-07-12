class Project < ApplicationRecord
  has_many :allocations
  has_many :users, through: :allocations

  validates :name, presence: true
  validates :cost, presence: true, numericality: { greater_than: 0 }

  def total_funded
    allocations.sum(:amount)
  end
end
