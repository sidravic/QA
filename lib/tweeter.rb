require 'oauth_authorization'
require 'twitter'

class Tweeter
  include OauthAuthorization::Twitter
  def initialize(access_token, access_secret)
    Twitter.configure do |config|
      config.consumer_key = OauthAuthorization::Twitter::CONSUMER_KEY
      config.consumer_secret = OauthAuthorization::Twitter::CONSUMER_SECRET
      config.oauth_token = access_token
      config.oauth_token_secret = access_secret
    end

    @client = initialize_client
  end


  def initialize_client
    Twitter::Client.new
  end

  def post_tweet(msg)
    @client.update(msg)
  end

  def self.tweet(msg, access_token = OauthAuthorization::Twitter::EasyQA_ACCESS_TOKEN, access_secret = OauthAuthorization::Twitter::EasyQA_ACCESS_SECRET)
    tweeter = Tweeter.new(access_token, access_secret)
    tweeter.post_tweet(msg)
  end
  

end