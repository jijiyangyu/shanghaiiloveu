# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :application, '51DM'
set :user, 'gongzi'
set :svn_username, 'gongzi'
set :server, '53gongzi.com'
set :svnserver, '53gongzi.svnrepository.com'
set :repository,  "http://#{svnserver}/svn/51dianming" 
set :deploy_to, "/home/#{user}/#{application}" 
role :web, server
role :app, server
role :db,  server, :primary => true

task :restart, :roles => :app do
end
task :after_update_code, :roles => [:web, :db, :app] do
  run "chmod 755 #{release_path}/public -R"
  run "(echo '1d'; echo '.'; echo 'wq') | ed -s #{release_path}/public/dispatch.fcgi"
  run "(echo '0a'; echo '#!/usr/local/bin/ruby'; echo '.'; echo 'wq') | ed -s #{release_path}/public/dispatch.fcgi"
  run "(echo '0a'; echo \"ENV['RAILS_ENV'] ||= 'production'\"; echo '.'; echo 'wq') | ed -s #{release_path}/config/environment.rb"
  run "(echo '32d'; echo '.'; echo 'wq') | ed -s #{release_path}/public/.htaccess"
  run "(echo '2d'; echo '.'; echo 'wq') | ed -s #{release_path}/public/.htaccess"
  run "(echo '33a'; echo 'RewriteRule ^(.*)$ dispatch.fcgi [QSA,L]'; echo '.'; echo 'wq') | ed -s #{release_path}/public/.htaccess"
  run "rm -rf public_html"
  run "ln -s /home/#{user}/#{application}/current/public /home/#{user}/public_html"
   
end