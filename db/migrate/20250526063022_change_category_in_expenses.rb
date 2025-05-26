class ChangeCategoryInExpenses < ActiveRecord::Migration[6.0]
  def change
    remove_column :expenses, :category, :string
    add_reference :expenses, :category, foreign_key: true
  end
end
