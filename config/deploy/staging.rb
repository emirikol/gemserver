set :rack_env, 'staging'
set :user, "gemserver_staging"
server 'staging2.iplan.co.il', roles: [:app, :web], user: fetch(:user)
