class CreateInstructions < ActiveRecord::Migration[5.1]
  def change
    create_table :instructions do |t|
    	t.string :name
    	t.text :content
    	t.string :cook_time

      t.timestamps
    end
  end
end
