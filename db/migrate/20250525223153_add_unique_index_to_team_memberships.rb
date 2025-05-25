class AddUniqueIndexToTeamMemberships < ActiveRecord::Migration[8.0]
  def change
    add_index :team_memberships, [:user_id, :team_id], unique: true
  end
end
