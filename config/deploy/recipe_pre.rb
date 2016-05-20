role :app, %w{ubuntu@52.16.152.86}
role :web, %w{ubuntu@52.16.152.86}
role :db,  %w{ubuntu@52.16.152.86}
set :rvm_ruby_version, 'ruby-2.0.0-p645'

role :resque_worker, '52.16.152.86'
role :resque_scheduler, '52.16.152.86'

set :rails_env, "preproduction"

set :assets_roles, [:web, :app]

server '52.16.152.86', user: 'ubuntu', roles: %w{web app}, port: 22#, my_property: :my_value

set :user, 'ubuntu'
# set :use_sudo, true
set :deploy_to, "/srv/ror/PREDMSELECT"

set :ssh_options, {
                    forward_agent: true,
                    auth_methods: ["publickey"],
                    keys: ["~/.ssh/dmsInterna_rescue.pem"]
                }

set :branch, 'Pre-Peticion'
