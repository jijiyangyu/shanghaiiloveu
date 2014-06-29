class Headline < ActiveRecord::Base

  def self.hot_headlines
    Headline.find(:all, :limit => 4, :order => 'show_num ASC, created_at DESC')
  end

end
