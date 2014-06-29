class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :user_id, :integer, :null =>false
      t.column :theme, :string, :null =>false
      t.column :idea, :text
      t.column :comment, :text
      t.timestamps
    end
    add_index :comments, :user_id, :UNIQUE
  end

  def self.down
    drop_table :comments
  end
end
