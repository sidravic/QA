namespace :t do
  desc "Runs RSpec Tests"
  task :rspec => :environment do
    sh "rspec spec/" do |status, response|
      puts "STATUS #{status} \n RESPONSE #{response}"
    end
  end
end