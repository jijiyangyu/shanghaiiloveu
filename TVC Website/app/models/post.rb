class Post < ActiveRecord::Base

  def self.category_posts(category_id)
    Post.find(:all,
      :conditions=>["to_post=1 and category_id=?", category_id],
      :limit => 5, :order => 'show_num ASC, created_at DESC')
  end

end
