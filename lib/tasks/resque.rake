# require 'resque/tasks'
# task "resque:setup" => :environment do
#   ENV['QUEUE'] = ENV['EMAIL_RESQUE_QUEUE']
#
# end
# require "#{File.dirname(__FILE__)}/../email_receiver.rb"
#
#
#
# desc "Alias for resque:work (to let us imagine that we are on Heroku)"
# task "jobs:work" => ["resque:work", :environment]