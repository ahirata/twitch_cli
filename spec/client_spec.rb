require 'twitch_cli'

module TwitchCli
  RSpec.describe Client, :vcr => true do

    let(:api) { Client.new }

    it "queries the top N games" do
      expect(api.get_games["top"].length).to be > 0
    end

    it "queries the top N streams for the specified game" do
      result = api.get_streams("StarCraft II: Heart of the Swarm")
      expect(result["streams"].length).to be > 0
    end

  end
end
