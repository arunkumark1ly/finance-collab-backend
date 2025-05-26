class Expense < ApplicationRecord
  belongs_to :team
  belongs_to :user

  validates :amount, :description, :category, :spent_on, presence: true
end
