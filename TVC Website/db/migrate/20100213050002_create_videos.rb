class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.column :title, :string, :null=>false
      t.column :video_address, :string
      t.column :player_address, :string
      t.column :image_address, :string
      t.column :src_address, :string
      t.column :show_num, :integer
      t.column :owner, :string
      t.column :film_or_not, :boolean, :null=>false
      t.column :src_or_not, :boolean, :null=>false
      t.column :home, :boolean, :null=>false, :default => false
      t.column :remark, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
