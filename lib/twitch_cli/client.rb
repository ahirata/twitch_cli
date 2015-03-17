require 'httparty'
require 'logger'

module TwitchCli
  class Client
    include HTTParty

    base_uri "https://api.twitch.tv/kraken"
    VERSION = "application/vnd.twitchtv.v3+json"

    def initialize *args
      super
      @options = { :headers => {"Accept" => VERSION} }
    end

    def get_games offset=0
      self.class.get("/games/top", {query: {:offset => offset}.merge!(@options)})
    end

    def get_streams game
      self.class.get("/streams", {query: {:game => game}.merge!(@options)})
    end
  end
end
