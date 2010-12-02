class CreatePindatas < ActiveRecord::Migration
  def self.up
    create_table :pindatas do |t|
      t.text :body
      t.string :company
      t.string :joblocation
      t.string :education
      t.integer :occupation_id
      t.integer :employment_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pindatas
  end
end
