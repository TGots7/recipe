class CreateInstructionIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :instruction_ingredients do |t|
    	t.integer :instruction_id 
    	t.integer :ingredient_id

      t.timestamps
    end
  end
end
