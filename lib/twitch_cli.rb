require 'thor'
require_relative 'twitch_cli/client'

module TwitchCli
  class App < Thor
    class_option :config, :type => :string, :banner => "FILE", :desc => "Use this YAML configuration file", :default => File.join(Dir.home, ".twitch_cli.yml")
    class_option :more, :type => :boolean, :desc => "fetch multiple pages"

    attr_accessor :client, :config

    def initialize *args
      super
      @client = Client.new
      @config = File.exist?(options[:config]) ? YAML.load_file(options[:config]) : {}
    end

    desc "games", "lists the games being streamed"
    def games
      offset = 0
      loop do
        result = client.get_games offset
        result["top"].each do |game|
          say self.class.game_to_str(game)
        end
        offset += result["top"].length
        break unless options[:more] && yes?("Type 'y' to fetch more games")
      end
    end

    desc "streams [GAME]", "list the online users streaming [GAME]"
    def streams game=@config["game"]
      offset = 0
      loop do
        result = client.get_streams(game, offset)
        result["streams"].each do |stream|
          say self.class.stream_to_str(stream)
        end
        offset += result["streams"].length
        break unless options[:more] && yes?("Type 'y' to fetch more streams")
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

