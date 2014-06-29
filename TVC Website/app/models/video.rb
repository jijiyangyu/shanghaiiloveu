class Video < ActiveRecord::Base
  def self.home_video
    return Video.find_by_home(1)
  end
end
