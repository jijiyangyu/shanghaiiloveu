class Comment < ActiveRecord::Base

  def self.validate_params(params)
    validation=[]
    validation << ["<li>请为我们的活动提供一点建议吧"] if params[:comment].nil? || params[:comment].to_s.length==0
    validation << ["<li>请描述一下你心中“上海，我爱你”"] if params[:idea].nil? || params[:idea].to_s.length==0
    return validation
  end

end
