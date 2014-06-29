class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.column :user_id, :integer, :null =>false
      t.column :name, :string, :null =>false
      t.column :email, :string
      t.column :cell, :string
      t.column :qq, :string
      t.column :msn, :string
      t.column :sex, :boolean, :null =>false
      t.column :birthday, :date, :null =>false
      t.column :constellation, :string, :null =>false
      t.column :job, :string, :null =>false
      t.column :field, :string, :null =>false
      t.column :status, :string, :null =>false #1 new, 2 delete, 3 recurit
      t.timestamps
    end
    add_index :people, :user_id, :UNIQUE
  end

  def self.down
    drop_table :people
  end
end
