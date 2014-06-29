class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.column :title, :string, :null=>false
      t.column :address, :string, :null =>false
      t.column :show_num, :integer
      t.column :remark, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
