class RegisterController < ApplicationController
  verify :method=>[:post], :except =>[:index,:thanks], :redirect_to => {:action=>"index"}

  def index
    @page_title = "加入活动"
    @user=User.new
    @person = Person.new
    @comment = Comment.new
    @resource = Resource.new
  end

  def thanks
    @page_title = "感谢参加"
  end

  def post_resource
    @resource = Resource.new
    @resource.time=request.raw_post.to_s.split('&')[0]
    if @resource.time.to_s=="%E5%89%A7%E6%9C%AC%E4%BD%9C%E5%AE%B6%2F%E6%96%87%E6%A1%88%E6%8A%A2%E6%89%8B"
      @resource.resource="比如：关于“上海，我爱你”，有好的素材和剧本愿意提供"
    elsif @resource.time.to_s=="%E5%BD%B1%E9%9F%B3%E5%88%B6%E4%BD%9C%2F%E5%B9%B3%E9%9D%A2%E8%AE%BE%E8%AE%A1"
      @resource.resource="比如：器材/拍摄场地/处理设备，可以提供平面设计等"
    elsif @resource.time.to_s=="%E5%BD%B1%E8%A7%86%E8%A1%A8%E6%BC%94%2F%E7%BE%8E%E5%B7%A5%E5%8C%96%E5%A6%86"
      @resource.resource="比如：愿意表演/有演员/化妆资源可以提供"
    elsif @resource.time.to_s=="%E5%AE%A3%E4%BC%A0%E7%AD%96%E5%88%92%2F%E5%AA%92%E4%BD%93%E5%85%AC%E5%85%B3"
      @resource.resource="比如：有媒体（网络/平面/电台/活动）渠道平台可以提供"
    elsif @resource.time.to_s=="%E7%BD%91%E7%AB%99%E8%AE%BE%E8%AE%A1%2F%E6%8A%80%E6%9C%AF%E5%BC%80%E5%8F%91"
      @resource.resource="比如：可以提供网络站点的开发/管理/空间的资源支持"
    elsif @resource.time.to_s=="%E7%AE%A1%E7%90%86%E5%8D%8F%E8%B0%83%2F%E8%BF%90%E8%90%A5%E6%94%AF%E6%8C%81"
      @resource.resource="比如：有相关项目管理协调经验，或者运营，物资资源的支持"
    end
    render :inline=>%{<%=text_area 'resource', 'resource', :style=>"width:500px;height:200px" %>}
  end

  def submit_questionnaire
    @error = []
    @error << User.validate_params(params[:person]) if User.validate_params(params[:person]).length>0
    @error << Person.validate_contact(params[:qq],params[:msn],params[:cell],params[:email])  if Person.validate_contact(params[:qq],params[:msn],params[:cell],params[:email]).length>0
    @error << Person.validate_params(params[:person]) if Person.validate_params(params[:person]).length>0
    @error << Resource.validate_params(params[:resource]) if Resource.validate_params(params[:resource]).length>0
    @error << Comment.validate_params(params[:comment]) if Comment.validate_params(params[:comment]).length>0
    unless @error.length==0
      @height=@error.length*30+30
      render :update do |page|
        page.call('openAlert',@error,200, @height)
      end
    else
      @user=User.create_user(params[:person][:name],request.env['REMOTE_HOST'])
      @user.person = Person.new(params[:person])
      @user.resource=Resource.new(params[:resource])
      @user.comment=Comment.new(params[:comment])
      if  @user.save
        puts "success"
        @user.submit_answers(params)
        flash[:notice]='谢谢您，注册成功！'
      end
      render :update do |page|
        page.redirect_to :controller=>'register',:action => 'thanks'
      end
    end
  end
end

