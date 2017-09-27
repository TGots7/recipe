class AddColumnToInstructions < ActiveRecord::Migration[5.1]
  def change
  	add_column :instructions, :user_id, :integer
  end
end
