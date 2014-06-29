class AdminController < ApplicationController
  require 'faster_csv'
  before_filter :admin_authorize, :except =>[:login,:logout]
  
  def index
    @header = "显示未定"
    @pages, @people = paginate(:people,:conditions=>"status=1",:order=>'updated_at DESC',:per_page => 10)
  end

  def login
    if request.post?
      #unless Validation.validate(session[:code],params[:home][:code])
       # session[:code]=nil
       # flash[:notice]="请完成边上的算术题"
      #else
        user = User.try_to_login(params[:home])
        unless user.nil?
          session[:user_id] = user.id
          redirect_to :controller=>"admin"
        else
          flash[:notice] = "查无此人或者密码有误!"
        end
      #end
    end
  end

  def logout
    user_logout
    redirect_to :controller=> 'home'
  end

  def change_password
    if request.post?
      unless Validation.validate(session[:code],params[:home][:code])
        session[:code]=nil
        flash[:notice]="请完成边上的算术题"
      else
        user = User.find(session[:user_id])
        unless user.nil?
          flash[:notice] = user.change_password(params[:home])
        else
          session[:user_id] = nil
          flash[:notice] = "请登陆后再修改密码!"
          redirect_to :controller=>"admin"
        end
      end
   end
  end

    def export
      unless request.get?
        start_date = Time.local(params[:admin]["start_date(1i)"],params[:admin]["start_date(2i)"],params[:admin]["start_date(3i)"],0,0,0)
        end_date = Time.local(params[:admin]["end_date(1i)"],params[:admin]["end_date(2i)"],params[:admin]["end_date(3i)"],23,59,59)
        @people=Person.find(:all,
          :conditions=>["created_at>=? and created_at<=?", start_date,end_date])
        csv_string = FasterCSV.generate do |csv|
          csv << ["创建时间","状态","称呼","性别","出生年份","星座","电子邮件","手机","QQ","MSN","工作情况","时间安排","特长技能","资源备注","电影评价","主题观点","活动建议"]
          @people.each do |u|
            if u.status.to_i==3
              csv << [u.created_at,"已经确定",u.name, u.sex ? '男' : "女",u.birthday.year, u.constellation, u.email, u.cell, u.qq, u.msn, u.job, u.user.resource.time, u.field, u.user.resource.resource, u.user.comment.theme, u.user.comment.idea, u.user.comment.comment ]
            elsif u.status.to_i == 2
              csv << [u.created_at,"已经删除",u.name, u.sex ? '男' : "女",u.birthday.year, u.constellation, u.email, u.cell, u.qq, u.msn, u.job, u.user.resource.time, u.field, u.user.resource.resource, u.user.comment.theme, u.user.comment.idea, u.user.comment.comment ]
            else
              csv << [u.created_at,"还未确定",u.name, u.sex ? '男' : "女",u.birthday.year, u.constellation, u.email, u.cell, u.qq, u.msn, u.job, u.user.resource.time, u.field, u.user.resource.resource, u.user.comment.theme, u.user.comment.idea, u.user.comment.comment ]
            end
          end
        end
        send_data csv_string,
          :type=>'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=questionnaire.csv"
      end
    end

    #headlines

    def list_headlines
      @headlines = Headline.all
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @headlines }
      end
    end

    def show_headlines
      @headline = Headline.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @headline }
      end
    end

    def new_headlines
      @headline = Headline.new
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @headline }
      end
    end

    def edit_headlines
      @headline = Headline.find(params[:id])
    end
  
    def create_headlines
      @headline = Headline.new(params[:admin])
      respond_to do |format|
        if @headline.save
          flash[:notice] = '网站头条成功创建'
          format.html { redirect_to :controller=>"admin",:action=>"show_headlines",:id=>@headline.id }
          format.xml  { render :xml => @headline, :status => :created, :location => @headline }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @headline.errors, :status => :unprocessable_entity }
        end
      end
    end

    def update_headlines
      @headline = Headline.find(params[:id])
      respond_to do |format|
        if @headline.update_attributes(params[:admin])
          flash[:notice] = '网站头条成功跟新'
          format.html { redirect_to :controller=>"admin",:action=>"show_headlines",:id=>@headline.id }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @headline.errors, :status => :unprocessable_entity }
        end
      end
    end

    def destroy_headlines
      @headline = Headline.find(params[:id])
      if @headline.destroy
        flash[:notice] = '网站头条删除成功'
      else
        flash[:notice] = '网站头条删除失败'
      end
    
      respond_to do |format|
        format.html { redirect_to :controller=>"admin",:action=>"list_headlines" }
        format.xml  { head :ok }
      end
    end


    #links
    def list_links
      @links = Link.all
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @links }
      end
    end

    def show_links
      @link = Link.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @link }
      end
    end

    def new_links
      @link = Link.new
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @link }
      end
    end

    def edit_links
      @link = Link.find(params[:id])
    end

    def create_links
      @link = Link.new(params[:admin])
      respond_to do |format|
        if @link.save
          flash[:notice] = '相关链接成功创建'
          format.html { redirect_to :controller=>"admin",:action=>"show_links",:id=>@link.id }
          format.xml  { render :xml => @link, :status => :created, :location => @link }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
        end
      end
    end

    def update_links
      @link = Link.find(params[:id])
      respond_to do |format|
        if @link.update_attributes(params[:admin])
          flash[:notice] = '相关链接成功跟新'
          format.html { redirect_to :controller=>"admin",:action=>"show_links",:id=>@link.id }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
        end
      end
    end

    def destroy_links
      @link = Link.find(params[:id])
      if @link.destroy
        flash[:notice] = '相关链接删除成功'
      else
        flash[:notice] = '相关链接删除失败'
      end

      respond_to do |format|
        format.html { redirect_to :controller=>"admin",:action=>"list_links" }
        format.xml  { head :ok }
      end
    end
    #videos
    def list_videos
      @pages, @videos = paginate(:videos,:order=>'created_at DESC',:per_page => 10)
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @videos }
      end
    end

    def show_videos
      @video = Video.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @video }
      end
    end

    def new_videos
      @video = Video.new
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @video }
      end
    end

    def edit_videos
      @video = Video.find(params[:id])
    end

    def create_videos
      @video = Video.new(params[:admin])
      respond_to do |format|
        if @video.save
          flash[:notice] = '视频内容成功创建'
          format.html { redirect_to :controller=>"admin",:action=>"show_videos",:id=>@video.id }
          format.xml  { render :xml => @video, :status => :created, :location => @video }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
        end
      end
    end

    def update_videos
      @video = Video.find(params[:id])
      respond_to do |format|
        if @video.update_attributes(params[:admin])
          flash[:notice] = '视频内容成功跟新'
          format.html { redirect_to :controller=>"admin",:action=>"show_videos",:id=>@video.id }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
        end
      end
    end

    def destroy_videos
      @video = Video.find(params[:id])
      if @video.destroy
        flash[:notice] = '视频内容删除成功'
      else
        flash[:notice] = '视频内容删除失败'
      end

      respond_to do |format|
        format.html { redirect_to :controller=>"admin",:action=>"list_videos" }
        format.xml  { head :ok }
      end
    end

    #pictures
    def list_pictures
      @pictures = Picture.all
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @pictures }
      end
    end

    def show_pictures
      @picture = Picture.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @picture }
      end
    end

    def new_pictures
      @picture = Picture.new
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @picture }
      end
    end

    def edit_pictures
      @picture = Picture.find(params[:id])
    end

    def create_pictures
      @picture = Picture.new(params[:admin])
      respond_to do |format|
        if @picture.save
          flash[:notice] = '首页图片成功创建'
          format.html { redirect_to :controller=>"admin",:action=>"show_pictures",:id=>@picture.id }
          format.xml  { render :xml => @picture, :status => :created, :location => @picture }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
        end
      end
    end

    def update_pictures
      @picture = Picture.find(params[:id])
      respond_to do |format|
        if @picture.update_attributes(params[:admin])
          flash[:notice] = '首页图片成功跟新'
          format.html { redirect_to :controller=>"admin",:action=>"show_pictures",:id=>@picture.id }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
        end
      end
    end

    def destroy_pictures
      @picture = Picture.find(params[:id])
      if @picture.destroy
        flash[:notice] = '首页图片删除成功'
      else
        flash[:notice] = '首页图片删除失败'
      end

      respond_to do |format|
        format.html { redirect_to :controller=>"admin",:action=>"list_pictures" }
        format.xml  { head :ok }
      end
    end

    #people
    def list_delete_people
      @header = "显示剔除"
      @pages, @people = paginate(:people,:conditions=>"status=2",:order=>'updated_at DESC',:per_page => 10)
    end
  
    def list_enroll_people
      @header = "显示确定"
      @pages, @people = paginate(:people,:conditions=>"status=3",:order=>'updated_at DESC',:per_page => 10)
    end

    def list_all_people
      @header = "显示全部"
      @pages, @people = paginate(:people,:order=>'updated_at DESC',:per_page => 10)
    end

    def show_people
      @person = Person.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @person }
      end
    end

    def delete_people
      if person = Person.find(params[:id])
        person.status = 2
        person.save
        flash[:notice] = '用户资料成功移至删除处'
      end
      redirect_to :controller => "admin"
    end

    def enroll_people
      if person = Person.find(params[:id])
        person.status = 3
        person.save
        flash[:notice] = '用户资料成功移至确定处'
      end
      redirect_to :controller => "admin"
    end

    def release_people
      if person = Person.find(params[:id])
        person.status = 1
        person.save
        flash[:notice] = '用户资料成功移至未定处'
      end
      redirect_to :controller => "admin", :action => params[:act]
    end

    def delete_show_people
      if person = Person.find(params[:id])
        person.status = 2
        person.save
        flash[:notice] = '用户资料成功移至删除处'
      end
      redirect_to :controller => "admin", :action=>"show_people", :id=>person.id
    end

    def enroll_show_people
      if person = Person.find(params[:id])
        person.status = 3
        person.save
        flash[:notice] = '用户资料成功移至确定处'
      end
      redirect_to :controller => "admin", :action=>"show_people", :id=>person.id
    end

    def release_show_people
      if person = Person.find(params[:id])
        person.status = 1
        person.save
        flash[:notice] = '用户资料成功移至未定处'
      end
      redirect_to :controller => "admin", :action=>"show_people", :id=>person.id
    end
    #post

    def list_posts
      @pages, @posts = paginate(:posts,:order=>'updated_at DESC',:per_page => 10)
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @posts }
      end
    end

    def show_posts
      @post = Post.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @post }
      end
    end

    def new_posts
      @post = Post.new
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @post }
      end
    end

    def edit_posts
      @post = Post.find(params[:id])
    end

    def create_posts
      @post = Post.new(params[:admin])
      respond_to do |format|
        if @post.save
          flash[:notice] = '网站文案成功创建'
          format.html { redirect_to :controller=>"admin",:action=>"show_posts",:id=>@post.id }
          format.xml  { render :xml => @post, :status => :created, :location => @post }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
        end
      end
    end

    def update_posts
      @post = Post.find(params[:id])
      respond_to do |format|
        if @post.update_attributes(params[:admin])
          flash[:notice] = '网站文案成功更新'
          format.html { redirect_to :controller=>"admin",:action=>"show_posts",:id=>@post.id }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
        end
      end
    end

    def destroy_posts
      @post = Post.find(params[:id])
      if @post.destroy
        flash[:notice] = '网站文案删除成功'
      else
        flash[:notice] = '网站文案删除失败'
      end
      respond_to do |format|
        format.html { redirect_to :controller=>"admin",:action=>"list_posts" }
        format.xml  { head :ok }
      end
    end

    def preview_posts
      @post = Post.find(params[:id])
      render :layout=>"application"
    end
    # end

  end
