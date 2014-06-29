require "digest/sha1"
class User < ActiveRecord::Base
  has_one :person
  has_one :resource
  has_one :comment
  has_many :answers

  validates_presence_of :name
  validates_uniqueness_of :name

  attr_accessor :hashed_password

  def before_create
    create_new_salt
    self.name = self.name.to_s + self.salt.to_s + self.id.to_s
    self.password = User.encrypted_password(self.password, self.salt)
    self.administrative = User.find_by_administrative(true).nil? ? 1 : 0
  end

  def check_name(user_name='')
    unless user_name=~/[\d\w]{1,20}/
      return '注意，请输入有效的用户名。', false
    end
  end

  def self.validate_params(params)
    validation=[]
    validation << ["<li>用户名存在或输入无效"] unless params[:name]=~/[\d\w]{1,20}/
    return validation
  end

  def self.create_user(the_name,user_ip)
    new_user = User.new
    new_user.name = the_name
    new_user.created_ip = user_ip
    new_user.administrative = false
    return new_user
  end

  def submit_answers(answers)
    answers.keys.each do |parent_key|
      answers[parent_key].each  do |key, value|
        if the_column=Map.find_by_table_and_field(parent_key, key)
          self.answers << Answer.create_answer(the_column, value)
        end
      end
    end
    self.save
  end

  def self.admin_authorize(user_id)
    user = User.find_by_id(user_id)
    unless user.nil?
      user.administrative
    else
      false
    end
  end

  def self.login(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = User.encrypted_password(password, user.salt)
      if user.password != expected_password
        return nil
      end
    end
    return user
  end

  def self.try_to_login(params)
    return User.login(params[:name], params[:password])
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def change_password(params)
    if params[:confirm_password].to_s==params[:new_password].to_s && params[:confirm_password].to_s.length>=3 && params[:confirm_password].to_s.length<=9
      expected_password = User.encrypted_password(params[:old_password], self.salt)
      if self.password != expected_password
        return "输入的原密码不匹配"
      else
        self.password = User.encrypted_password(params[:new_password], self.salt)
        self.save
        return "密码修改成功"
      end
    else
      return "新密码与确认密码不匹配或者不符合规范"
    end
  end

  def self.encrypted_password(password, salt)
    unless password.nil?
      string_to_hash = password + "shanghai" + salt
    else
      string_to_hash = "shanghai" + salt
    end
    Digest::SHA1.hexdigest(string_to_hash)
  end
end
