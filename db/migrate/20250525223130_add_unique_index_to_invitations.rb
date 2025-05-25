class AddUniqueIndexToInvitations < ActiveRecord::Migration[8.0]
  def change
    add_index :invitations, [:email, :team_id], unique: true
  end
end
