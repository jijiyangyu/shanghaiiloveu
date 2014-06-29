class Resource < ActiveRecord::Base
  belongs_to :user

  def self.validate_params(params)
    validation=[]
    validation << ["<li>请在擅长/资源给些留言吧"] if params[:resource].nil? || params[:resource].to_s.length==0
    return validation
  end

end
