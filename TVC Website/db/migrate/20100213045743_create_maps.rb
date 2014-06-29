class CreateMaps < ActiveRecord::Migration
  def self.up
    create_table :maps do |t|
      t.column :table, :string, :null =>false
      t.column :field, :string, :null =>false
      t.column :question_id, :integer, :null =>false
      t.timestamps
    end
    add_index :maps, :question_id
  end

  def self.down
    drop_table :maps
  end
end
