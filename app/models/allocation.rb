class Allocation < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validate :user_budget_not_exceeded

  def user_budget_not_exceeded
    return if user.nil?

    total = user.allocations.where.not(id: id).sum(:amount) + (amount || 0)
    if total > 1000
      errors.add(:amount, "exceeds your $1,000 voting budget")
    end
  end
end
