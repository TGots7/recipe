class AddColumnToInstructionIngredients < ActiveRecord::Migration[5.1]
  def change
  	add_column :instruction_ingredients, :quantity, :string
  end
end
