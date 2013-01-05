class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :user_id,       :null => false
      t.string  :venue_id,      :null => false
      t.string  :foursquare_id, :null => false

      t.timestamps
    end

    add_index :checkins, [:user_id, :venue_id]
  end
end
