# config valid only for current version of Capistrano
lock '3.4'

set :application, 'DMSELECT'
set :repo_url, 'git@github.com:DMSti/DMSELECT.git'

# role :resque_worker, '52.16.152.86'
# role :resque_scheduler, '52.16.152.86'
# set :workers, { :pro_queue => 5 }

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

#Load the environment task automatically
set :resque_environment_task, true

set :resque_log_file, "log/resque.log"

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
# set :rvm_ruby_version, 'ruby-2.0.0-p247'
# set :default_env, { rvm_bin_path: '~/.rvm/bin' }
# SSHKit.config.command_map[:rake] = "#{fetch(:default_env)[:rvm_bin_path]}/rvm ruby-#{fetch(:rvm_ruby_version)} do bundle exec rake"


namespace :deploy do

  desc 'Set install gems'
  task :production do
    set :bundle_without, [:development, :test]
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :restart_workers do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'Diversos cambios necesarios para funcionamiento de app'
  task :settings do
    on roles(:web, :app) do
      # Permisos para ejecutar el script de lectura y tratamiento de email con adjuntos
      # execute "cd #{release_path} && chmod 755 lib/email_receiver_script.rb"
      #
      # # STOP colas de resque
      # # execute "cd #{release_path} && ps aux | grep queue | awk '{print $2}' | xargs kill -9"
      # # START colas de resque
      # # execute "cd #{release_path} && sudo ~/.rvm/bin/rvm ruby-2.0.0-p247 do bundle exec rake RAILS_ENV=production resque:work BACKGROUND=yes QUEUE='email_queue'"
      #
      # # Deploy de nodejs y puesta en marcha
      # execute "sudo forever stopall"
      # execute "cp -R #{release_path}/nodejs-qliksense /home/ubuntu"
      # execute "cd /home/ubuntu/nodejs-qliksense && forever start server.js"
    end
  end

  desc 'Restaura database.yml'
  before :updated, :preparandooo do
    on roles(:web, :app) do
      execute "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  end

  # task :database_restore do
  #   on roles(:web, :app) do
  #     execute "ln -s #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  #     execute "cd #{release_path} && cd ../../ && cp shared/public/config/database.yml #{release_path}/config"
  #   end
  # endgod

  after :updated, 'deploy:settings'
  # after :updated, :arrancar_resque_con_scheduler do
  #   on roles( :web, :app) do
  #     execute "rake resque:scheduler"
  #   end
  # end

  # after :finishing, 'deploy:database_restore'
  after :finished, 'deploy:restart'
  # after :restart, 'resque:restart



  desc 'Hot-reload God configuration for the Resque worker'
  task :reload_god_config do
    on roles(:web, :app) do
      execute "sudo service god stop"
      # execute "god load #{File.join(deploy_to, 'current', 'config', 'resque.god')}"
      execute "sudo service god start"
    end
  end


  after :deploy, 'deploy:reload_god_config'

end

namespace :db do

  desc 'Descarga copia de BBDD de servidor AWS(PRO)'
  task :copiar_y_descargar do
    on roles(:app) do
      fecha = DateTime.now.strftime("%Y%m%d")
      execute "mysqldump -uroot -pdms #{fetch(:stage)} > /repositorio/copias_bbdd/#{fecha}_#{fetch(:stage)}.sql "
      system "scp -i $HOME/.ssh/dmsInterna.20150304.pem root@predmsig.dmsti.biz:/repositorio/copias_bbdd/#{fetch(:stage)}.sql.tar.gz ."
    end
  end

end




