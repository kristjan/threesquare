class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.integer :checkin_id,  :null => false
      t.string  :description, :null => false
      t.integer :rating,      :null => false

      t.timestamps
    end

    add_index :foods, :checkin_id
  end
end
