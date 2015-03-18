require 'twitch_cli'

module TwitchCli
  RSpec.describe App do

    let(:games) {[
      { "game" => { "name" => "g1"}},
      { "game" => { "name" => "g2"}},
      { "game" => { "name" => "g3"}},
      { "game" => { "name" => "g4"}}
    ]}
    let(:streams) {[
      { "channel" => { "display_name" => "s1", "status" => "s1 msg" }},
      { "channel" => { "display_name" => "s2", "status" => "s2 msg" }},
      { "channel" => { "display_name" => "s3", "status" => "s3 msg" }},
      { "channel" => { "display_name" => "s4", "status" => "s4 msg" }},
    ]}

    let(:client) { double("twitch_client")}

    let(:shell) { Thor::Base.shell.new }

    before do
      allow(Client).to receive(:new).and_return(client)
    end

    it "formats game to string" do
      result = App.game_to_str(games.first)
      expect(result).to eql("g1")
    end

    it "formats stream to string" do
      result = App.stream_to_str(streams.first)
      expect(result).to eql("s1 - s1 msg")
    end

    it "accepts a configuration file" do
      expect(Configuration).to receive(:setup).with("somefile").and_return({"key"=>"value"})

      expect(App.new([], ["--config=somefile"]).config["key"]).to eql("value")
    end

    it "uses default filename for the configuration file" do
      expect(Configuration).to receive(:setup).with(File.join(Dir.home, ".twitch_cli")).and_return({"key"=>"value"})

      expect(App.new([], []).config["key"]).to eql("value")
    end

    it "doesnt break if there is no default configuration file" do
      expect(App.new([], []).config).to eql({})
    end

    it "lists the games being streamed" do
      allow(client).to receive(:get_games).and_return({"top" => games})
      games.each do |g|
        expect(shell).to receive(:say).with("#{App.game_to_str(g)}")
      end

      App.start(["games"], :shell => shell)
    end

    it "asks if should fetch more games" do
      allow(client).to receive(:get_games).with(0).and_return({"top" => games.slice(0,2)})
      allow(client).to receive(:get_games).with(2).and_return( {"top" => games.slice(2,2)})

      games.each do |g|
        expect(shell).to receive(:say).with("#{App.game_to_str(g)}")
      end
      expect(shell).to receive(:yes?).and_return(true, false)

      App.start(["games", "--more"], :shell => shell)
    end

    it "lists streams under a game" do
      allow(client).to receive(:get_streams).and_return({"streams" => streams})

      streams.each do |s|
        expect(shell).to receive(:say).with("#{App.stream_to_str(s)}")
      end

      App.start(["streams", "some_game"], :shell => shell)
    end
  end
end
