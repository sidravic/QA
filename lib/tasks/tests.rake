require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'



RSpec::Core::RakeTask.new(:all => ["ci:setup:rspec"]) do |t|
  t.pattern = '**/*_spec.rb'
end

=begin
namespace :t do
  desc "Runs RSpec Tests"
  task :rspec => :environment do
    sh "rspec spec/" do |status, response|
      puts "STATUS #{status} \n RESPONSE #{response}"
    end
  end
end
=end
