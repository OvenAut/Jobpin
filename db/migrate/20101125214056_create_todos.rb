class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.string :name
      t.boolean :finished
      t.boolean :defect
      t.text :body
      t.date :due

      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
