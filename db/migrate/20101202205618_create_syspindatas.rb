class CreateSyspindatas < ActiveRecord::Migration
  def self.up
    create_table :syspindatas do |t|
      t.string :sitesrcid, :default => "", :null => false
      t.string :dataurl
      t.string :datasrc
      t.boolean :geocook, :default => false
      t.integer :pindata_id 

      t.timestamps
    end
  end

  def self.down
    drop_table :syspindatas
  end
end
