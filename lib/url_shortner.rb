require 'open-uri'
module Shortner
  module BitlyConstants
    API_KEY = 'R_03faa0ac8be98f0e0c9c7469ea7c6ea1'
    LOGIN ='supersid'
    ENDPOINT = 'http://api.bit.ly/'
    SHORTEN_PATH = 'v3/shorten'
  end

  class Bitly
    include BitlyConstants

    def initialize
      @api_key = BitlyConstants::API_KEY
      @login = BitlyConstants::LOGIN
    end

    # expects mandatory
    # { :longUrl => 'http://twitter.com' }
    def shorten(options = {})
      raise 'Invalid URL ' if options[:longUrl].blank?      
      parameters = {:format => 'json', :login => @login, :apiKey => @api_key }.merge(options)      
      parameters[:longUrl] = encode_uri(parameters[:longUrl])
      end_point_uri = generate_end_point_uri(parameters, :shorten)
      response = open(end_point_uri)
      hashify(response.read)
    end

    def self.shorten(longUrl)
      bitly = Bitly.new
      bitly.shorten(:longUrl => longUrl)
    end


    private

    def encode_uri(long_uri)
      URI.escape(long_uri)
    end

    def generate_end_point_uri(parameters, op)
      url_parameters = ""
      parameters.each_with_index do |(key, value), index|
        url_parameters += "?#{key.to_s}=#{value}" if index == 0
        url_parameters += "&#{key.to_s}=#{value}" if index != 0
      end

      Shortner::BitlyConstants::ENDPOINT + get_end_point_path(op) + url_parameters
    end

    def get_end_point_path(op)
      case op
      when :shorten
        Shortner::BitlyConstants::SHORTEN_PATH
      end
    end

    #parses JSON response to a Hash
    def hashify(response)
      JSON.parse(response)
    end

  end
end