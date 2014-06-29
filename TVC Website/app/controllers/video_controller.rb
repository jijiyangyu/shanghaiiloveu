class VideoController < ApplicationController
  verify :method=>[:post], :except =>[:index,:showcase], :redirect_to => {:action=>"index"}

  def index
    @page_title = "视频资料"
    @pages, @videos = paginate(:videos,:order=>'created_at DESC',:per_page => 5)
  end

  def showcase
    @page_title = "视频资料"
    @video=Video.find_by_id(params[:id])
  end

end
