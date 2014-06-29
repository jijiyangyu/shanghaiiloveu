class Link < ActiveRecord::Base

  def self.hot_links
    Link.find(:all, :limit => 5, :order => 'show_num ASC, created_at DESC')
  end

end
