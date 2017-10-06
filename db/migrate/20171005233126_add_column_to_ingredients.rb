class AddColumnToIngredients < ActiveRecord::Migration[5.1]
  def change
  	add_column :ingredients, :organic, :boolean, :default => false
  end
end
