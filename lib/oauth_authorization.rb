require 'oauth'
module OauthAuthorization

  module Twitter
    EasyQA_ACCESS_TOKEN = '219897319-UoPggv1bC1G6NuSPpWhB6u58dXKbuy2ov6CAIS9S'
    EasyQA_ACCESS_SECRET = 'azhmGQApW6Q9zTniSOHuputuGIW9xBIjGJjPqABfbn8'
    CONSUMER_KEY = 'oSLYqq5yarPyTCkjEHKvw'
    CONSUMER_SECRET = 'jixKNd5B4Gji63xUILXjr29pf8Cczee3FnIS3xITTE'

    def self.options
      options = if RAILS_ENV == 'development'
        {
          :site               => "http://api.twitter.com",
          :scheme             => :header,
          :http_method        => :post,
          :request_token_path => "/oauth/request_token",
          :access_token_path  => "/oauth/access_token",
          :authorize_path     => "/oauth/authorize"
        }
      end
    end

    def self.callback
      if Rails.env == 'development'        
        "http://localhost:3000/"        
      end
    end
    
  end

  
  class OauthAccess
    include Twitter

    # expects {:for => :twitter }  or  {:for => :facebook }
    def initialize(options)      
      @options = options
      setup_consumer
    end    
    
    def request_token(options = {})      
      @consumer.get_request_token(options)
    end

    def access_token(verifier)
      @access_token = @request_token.get_access_token(:oauth_verifier => verifier)
    end
    
    #accepts options = { :callback => 'http://siddharth-ravichandran.com/twitter' }
    # provide the path to the controller#action that will handle the callback
    def authorization_uri(options ={})
      @request_token = request_token(options.merge({:oauth_callback => relevant_callback}))      
      @request_token.authorize_url
    end

    private

    def setup_consumer
      opts = relevant_options(@options[:for])      
      @consumer = OAuth::Consumer.new(@consumer_token, @consumer_secret, opts)
    end

    def relevant_options(option)
      if option == :twitter        
        @consumer_token = Twitter::CONSUMER_KEY
        @consumer_secret = Twitter::CONSUMER_SECRET
        Twitter.options
      end
    end

    def relevant_callback
      if @options[:for] == :twitter
        Twitter.callback
      end
    end
    
  end  
end