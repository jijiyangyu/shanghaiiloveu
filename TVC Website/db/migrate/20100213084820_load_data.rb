require 'active_record/fixtures'
class LoadData < ActiveRecord::Migration
  def self.up
    Dir.glob(File.join(File.dirname(__FILE__),'/../data','*.yml')).each do |fixture_file|
      Fixtures.create_fixtures(File.dirname(__FILE__)+ '/../data', File.basename(fixture_file, '.*'))
    end
    execute "update users set id=0 where id=1"
    User.find(:all).each do |user|
      unless user.nil?
        user.create_new_salt
        user.password=User.encrypted_password(user.password, user.salt)
        user.save
      end
    end
  end

  def self.down
    Answer.delete_all
    Headline.delete_all
    Link.delete_all
    Picture.delete_all
    Video.delete_all
    Map.delete_all
    Choice.delete_all
    Question.delete_all
  end
end
