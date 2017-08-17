# config valid only for current version of Capistrano
lock "3.9.0"

set :rbenv_ruby, '2.4.0'
set :rbenv_custom_path, "/opt/rbenv"

set :application, "eventlite"
set :repo_url, "git@github.com:nbudin/eventlite.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/eventlite"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads"

# doesn't really matter what we set here; this will be used for compiling assets
set :default_env, { SECRET_KEY_BASE: "e82ab9a15094359705b12d162ded247f7932c0ef4ff39f444f45704ed51c4c8f119cf9061c5264ff43654e37219f302c06fdfd4fd691e92bbcc233339eaa0549" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rollbar_token, ENV['ROLLBAR_TOKEN']
set :rollbar_env, Proc.new { fetch :stage }
set :rollbar_role, Proc.new { :app }

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

end
