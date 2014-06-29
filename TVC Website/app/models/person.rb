class Person < ActiveRecord::Base
  belongs_to :user

  def before_create
    self.status=1
  end

  def self.validate_params(params)
    validation=[]
    unless params[:qq].nil?
      validation << ["<li>请输一个正确的QQ号"] unless params[:qq]=~/^[\d]{5,13}/
    end
    unless params[:msn].nil?
      validation << ["<li>请输一个正确的MSN用户"] unless params[:msn]=~/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})/
    end
    unless params[:cell].nil?
      validation << ["<li>请输一个正确的手机号码"] unless params[:cell]=~/[\d\W]{6,20}/
    end
    unless params[:email].nil?
      validation << ["<li>请输一个正确的电子邮件地址"] unless params[:email]=~/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})/
    end
    return validation
  end

  def self.validate_contact(qq, msn, cell, email)
    validation = []
    return ["<li>请选择一个联系方式"] if qq[:validated].to_i==0 && msn[:validated].to_i==0 && cell[:validated].to_i==0 && email[:validated].to_i==0
    return validation
  end

end
