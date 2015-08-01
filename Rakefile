require "bundler/gem_tasks"
require "rspec/core/rake_task"

namespace :solr do
  desc "Start my enron solr instance."
  task :server do
    system 'cd ~/Documents/git/underTheHood-student-Solr-2013-11-03-0100/solr-4.5.1/example && java -jar start.jar'
  end

  desc "Load enron data (only run once as it is retained between restarts)"
  task :load do
    system 'cd ~/Documents/git/underTheHood-student-Solr-2013-11-03-0100/Activities && java -jar post.jar Enron/*.xml'
  end
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
