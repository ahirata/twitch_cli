require 'twitch_cli'

module TwitchCli
  RSpec.describe Client, :vcr => true do

    let(:api) { Client.new }

    it "queries the top N games" do
      expect(api.get_games["top"].length).to be > 0
    end

    it "queries the top N games from offset" do
      total = api.get_games
      offset = total["top"].length/2
      second_page = api.get_games(offset)

      expect(api.get_games["top"].length).to be > 0
      expect(second_page["top"][0]["game"]["name"]).to eql(total["top"][offset]["game"]["name"])
    end

    it "queries the top N streams for the specified game" do
      result = api.get_streams("StarCraft II: Heart of the Swarm")
      expect(result["streams"].length).to be > 0
    end

  end
end
