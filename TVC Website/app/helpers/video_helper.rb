module VideoHelper

  def show_perview(video)
    video.image_address=="" ?  "/images/preview.jpg" : h(video.image_address)
  end

end
