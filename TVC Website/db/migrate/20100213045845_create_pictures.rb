class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.column :title, :string
      t.column :home_address, :string, :null=>false
      t.column :banner_address, :string, :null =>false
      t.column :owner, :string
      t.column :remark, :string
      t.column :black_or_white, :boolean
      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
