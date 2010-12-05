class CreateGeodatapins < ActiveRecord::Migration
  def self.up
    create_table :geodatapins do |t|
      t.string :formatted_address ,:null => false
      t.float :lat ,:null => false
      t.float :lng ,:null => false
      t.integer :pindata_id ,:null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :geodatapins
  end
end
