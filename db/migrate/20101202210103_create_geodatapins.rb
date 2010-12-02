class CreateGeodatapins < ActiveRecord::Migration
  def self.up
    create_table :geodatapins do |t|
      t.string :formatted_address
      t.float :lat
      t.float :lng
      t.integer :pindata_id

      t.timestamps
    end
  end

  def self.down
    drop_table :geodatapins
  end
end
