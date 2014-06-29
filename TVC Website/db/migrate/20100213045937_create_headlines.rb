class CreateHeadlines < ActiveRecord::Migration
  def self.up
    create_table :headlines do |t|
      t.column :headline, :string, :null=>false
      t.column :title, :string, :null=>false
      t.column :address, :string, :null =>false
      t.column :show_num, :integer
      t.column :remark, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :headlines
  end
end
