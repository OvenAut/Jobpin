class CreatePins < ActiveRecord::Migration
  def self.up
    create_table :pins do |t|
      t.string :company
      t.decimal :latitude
      t.decimal :longitude
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :pins
  end
end
