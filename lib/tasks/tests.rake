=begin
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'



RSpec::Core::RakeTask.new(:all => ["ci:setup:rspec"]) do |t|
  t.pattern = '**/*_spec.rb'
end
=end


namespace :t do
  
  desc "Runs Bundle install"
  task :bundle => :environment do   
    sh "bundle install"
  end
  
  desc "Runs RSpec Tests"
  task :rspec => [:environment] do    
    exec "rspec spec" do |status, response|
      puts "STATUS #{status} \n RESPONSE #{response}"
    end    
  end
  
  desc "Runs the best practices gem to prescribe necessary changes"
  task :best_practices => [:environment, :bundle] do
    exec "rails_best_practices -f html ."
  end
  
  desc "Runs metric fu all"
  task :mfu => :environment do
    sh "echo $PATH"
    sh "rake metrics:all"
  end
  
  
end

