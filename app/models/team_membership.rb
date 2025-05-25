class TeamMembership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  # Validation to ensure uniqueness of user and team association
  validates :user_id, uniqueness: { scope: :team_id, message: "is already a member of this team" }
end
