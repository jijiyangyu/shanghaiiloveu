class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :name, :string, :null =>false
      t.column :password, :string, :null =>false
      t.column :created_ip, :string
      t.column :email, :string
      t.column :salt, :string
      t.column :administrative, :boolean, :null =>false,:default => false
      t.timestamps
    end
    add_index :users, :name, :UNIQUE
  end

  def self.down
    drop_table :users
  end
end
