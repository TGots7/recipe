class AddRatingsToInstructions < ActiveRecord::Migration[5.1]
  def change
  	add_column :instructions, :ratings, :integer, :default => 3
  end
end
