class Picture < ActiveRecord::Base
  def self.current_picture
    picture_num = Picture.count
    if picture_num < 2
      return Picture.find(:first)
    else
      top_num=rand(picture_num)
      #top_num=Date.today.to_i.divmod(Picture.count-1)
      return Picture.find(:first,:offset=>top_num)
    end
  end

  def previous_picture
    Picture.find(:first,:conditions =>["black_or_white=? and id<?",self.black_or_white,self.id])
  end

  def next_picture
    Picture.find(:first,:conditions =>["black_or_white=? and id>?",self.black_or_white,self.id])
  end

end
