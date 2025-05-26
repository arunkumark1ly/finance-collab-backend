class CreateAuditLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :audit_logs do |t|
      t.references :auditable, polymorphic: true, null: false
      t.string :action
      t.references :changed_by, foreign_key: { to_table: :users }
      t.json :previous_data
      t.json :new_data

      t.timestamps
    end
  end
end
