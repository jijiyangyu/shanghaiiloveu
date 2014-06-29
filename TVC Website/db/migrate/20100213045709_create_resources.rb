class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.column :user_id, :integer, :null =>false
      t.column :time, :string, :null =>false
      t.column :resource, :text
      t.timestamps
    end
    add_index :resources, :user_id, :UNIQUE
  end

  def self.down
    drop_table :resources
  end
end
