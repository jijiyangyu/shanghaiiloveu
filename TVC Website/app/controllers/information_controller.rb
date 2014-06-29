class InformationController < ApplicationController
  verify :method=>[:post], :except =>[:index,:temp], :redirect_to => {:action=>"index"}

  def index
    @page_title = "小组介绍"
    @post = Post.find_by_id_and_to_post(1,1)
  end

  def temp
    @page_title = "小组介绍"
  end

end
