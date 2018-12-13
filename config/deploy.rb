# config valid only for current version of Capistrano
lock '3.4.1'

set :application, 'gemserver'
set :repo_url, 'git@github.com:emirikol/gemserver.git'

set :rvm_ruby_version, "2.3.7"
set :rvm_type, :system
set :rvm_roles, [:all]
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, ->{ "/home/#{fetch(:user)}/apps/gemserver_#{fetch(:rack_env)}/" }
# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'data')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


set :rsync_options, %w[--recursive --exclude data/*]

