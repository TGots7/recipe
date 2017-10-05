class AddColumnToIngredients < ActiveRecord::Migration[5.1]
  def change
  	add_column :ingredients, :health_rating, :integer, :default => 3
  end
end
