module HomeHelper
  def show_home_picture(picture)
    return picture.nil? ? "/images/Anna.jpg" : h(picture.home_address)
  end
  
  def show_previous_picture(picture)
    if the_pic=picture.previous_picture
      link_to_remote '<div style="visibility: visible;" class="sc_light">◄</div>
<span style="display: block;">前一幅图片</span>',
        :complete=>visual_effect(:toggle_appear,'bgDiv',:duration=> 3),
        :url => { :action => "update_picture", :id => the_pic.id},
        :html => { :id  => "sh_igl" }
    else
      link_to_remote '<div style="visibility: visible;" class="sc_lightdis">◄</div>
<span style="display: none;">前一幅图片</span>',
        :html => { :id  => "sh_igl" }
    end
  end

  def show_next_picture(picture)
    if the_pic=picture.next_picture
      link_to_remote '<div style="visibility: visible;" class="sc_light">►</div>
<span style="display: block;">后一幅图片</span>',
        :complete=>visual_effect(:toggle_appear,'bgDiv',:duration=> 3),
        :url => { :action => "update_picture", :id => the_pic.id},
        :html => { :id  => "sh_igl" }
    else
      link_to_remote '<div style="visibility: visible;" class="sc_lightdis">►</div>
<span style="display: none;">后一幅图片</span>',
        :html => { :id  => "sh_igl" }
    end
  end

  def show_home_logo(picture)
    picture.nil? || picture.black_or_white ? "/images/black.png" : "/images/white.png"
  end

  def show_post(picture)
    picture.nil? || picture.black_or_white ? "style='color:white'" : "style='color:black'"
  end

  def show_posts(category_id)
    if posts=Post.category_posts(category_id)
      ret=""
      posts.each do |post|
        ret=ret+"<li>"+ link_to_remote(h(post.sidetitle), :url=>{:controller=>"home", :action=>'show_post',:id=>post.id}, :update=> 'results_container') +"</li>"
        #ret=ret+"<li>"+ link_to(h(post.sidetitle), :controller=>"home", :action=>'show_post',:id=>post.id) +"</li>"
      end
    end
    return ret
  end

  def show_category_title(category)
    if category.to_i==3
      "加入我们"
    elsif category.to_i==2
      "视频资料"
    else
      "小组介绍"
    end
  end



end
