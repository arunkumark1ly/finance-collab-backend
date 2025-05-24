class AddColumntoJwtDenylist < ActiveRecord::Migration[8.0]
  def change
    add_column :jwt_denylists, :exp, :datetime
  end
end
