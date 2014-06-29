class HomeController < ApplicationController
  verify :method=>[:post], :except =>[:index,:show_post,:post_validation], :redirect_to => {:action=>"index"}
  caches_page :index

  def index
    @page_title = "阿拉首页"
    @headlines=Headline.hot_headlines
    @picture=Picture.find(3)
    @video=Video.home_video
  end

  def show_post
    @post = Post.find_by_id_and_to_post(params[:id],1)
    unless @post.nil?
      if request.xhr?
        render :partial => "information/post", :locals => {:post => @post}
      else
        if @post.category_id.to_i==1
          @page_title = "小组介绍"
          @category = 1
        elsif @post.category_id.to_i==2
          @page_title = "视频资料"
          @category = 2
        else
          @page_title = "加入活动"
          @category = 3
        end
        render :template=>"information/index", :layout=>"application"
      end
    else
      redirect_to :controller => "home"
    end
  end

  def update_picture
    @picture=Picture.find(params[:id])
    render :update do |page|
      page.replace :bgDiv, :inline=>'<div class="sw_imLd" id="bgDiv" style="background-image: url(' + @picture.home_address + ')"></div>'
      page.replace_html :sh_rdiv, :partial=>"picture_space",:locals => {:picture => @picture}
    end
  end
  
  def about
    contents=params[:contents]
    render :update do |page|
      page.call('openAlert',contents.to_s, 200, 50)
    end
  end

  def about_site
    render :update do |page|
      page.call('openAlert','“上海，我爱你”电影制作小组（www.shanghaiiloveu.org）网站是“上海，我爱你”电影制作小组的交流平台，主要用于电影制作小组的用户发布的数据，文案以及相关信息。“上海，我爱你”电影制作小组反对不良、反动、色情信息。（www.shanghaiiloveu.org）网站不色情也不暴力，更不涉及反动信息。请大家安心访问，并接受群众监督。', 350, 135)
    end
  end

  def about_copyright
    render :update do |page|
      page.call('openAlert','“上海，我爱你”电影制作小组（www.shanghaiiloveu.org）网站是“上海，我爱你”电影制作小组的交流平台，网站中用户发布的数据，文案以及相关信息是为“上海，我爱你”电影制作小组（www.shanghaiiloveu.org）网站所有。“上海，我爱你”电影制作小组是其提供信息的权利人，未经用户许可，任何机构或个人均不得为商业目的（含潜在商业目的）使用网站中用户发布的信息。',350,135)
    end
  end

  def post_validation
    picture=Validation.new(params[:filename])
    session[:code]=picture.code
    send_data(picture.data,
      :filename=>picture.filename,
      :type =>picture.type,
      :disposition=>'inline')
  end

end
