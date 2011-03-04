# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'metric_fu'

MetricFu::Configuration.run do |config|
   config.rcov[:test_files] = ['spec/**/*_spec.rb']  
   config.rcov[:rcov_opts] << "-Ispec" # Needed to find spec_helper
   config.reek = { :dirs_to_reek => ['app', 'lib'] }
   config.flay ={:dirs_to_flay => ['app', 'lib'],
                  :minimum_score => 100,
                  :filetypes => ['rb'] 
                 }
   
end



Qa::Application.load_tasks
