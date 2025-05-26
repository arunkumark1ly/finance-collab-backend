class Category < ApplicationRecord
  has_many :expenses

  validates :name, presence: true, uniqueness: true  # Ensure category names are unique
end
