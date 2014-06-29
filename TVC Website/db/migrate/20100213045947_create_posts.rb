class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.column :title, :string, :null =>false
      t.column :sidetitle, :string, :null =>false
      t.column :subtitle, :string
      t.column :owner, :string
      t.column :summary, :string
      t.column :body, :text
      t.column :category_id, :integer, :null =>false #1 小组介绍, 2 短篇介绍, 3 活动介绍
      t.column :to_post, :boolean, :null =>false
      t.column :show_num, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
