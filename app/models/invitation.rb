class Invitation < ApplicationRecord
  belongs_to :team

  # Validation to ensure uniqueness of email scoped to team_id
  validates :email, presence: true, uniqueness: { scope: :team_id, message: "has already been invited to this team" }
end
