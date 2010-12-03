class AddValidToPindatas < ActiveRecord::Migration
  def self.up
    add_column :pindatas, :valid, :boolean
  end

  def self.down
    remove_column :pindatas, :valid
  end
end
