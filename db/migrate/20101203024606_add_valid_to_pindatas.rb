class AddValidToPindatas < ActiveRecord::Migration
  def self.up
    add_column :pindatas, :valid_pin, :boolean
  end

  def self.down
    remove_column :pindatas, :valid_pin
  end
end
