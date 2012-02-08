# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Lovelyromcoms::Application.load_tasks

desc "start mongo and solr"

task :start_mongo do
  if RUBY_PLATFORM.include? "darwin"
    exec "vendor/extras/mongodb/mongodb-osx-x86_64-2.0.2/bin/mongod &"
  elsif RUBY_PLATFORM.include? "linux"
    exec "vendor/extras/mongodb/mongodb-linux-x86_64-2.0.2/bin/mongod &"
  end
end

task :start_solr do
  exec "cd vendor/extras/apache-solr-3.5.0/example/;java -jar start.jar &"
end
