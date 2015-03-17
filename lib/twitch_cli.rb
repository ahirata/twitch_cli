require 'thor'
require_relative 'twitch_cli/client'

module TwitchCli
  class App < Thor
    attr_accessor :client

    def initialize *args
      super
      @client = Client.new
    end

    desc "games", "lists the games being streamed"
    def games
      result = client.get_games
      result["top"].each do |game|
        say self.class.game_to_str(game)
      end
    end

    desc "streams GAME", "list the online users streaming a GAME"
    def streams game
      result = client.get_streams(game)
      result["streams"].each do |stream|
        say self.class.stream_to_str(stream)
      end
    end

    def self.game_to_str game
        "#{game['game']['name']}".strip
    end

    def self.stream_to_str stream
        "#{stream['channel']['display_name']} - #{stream['channel']['status']}".strip
    end
  end
end

