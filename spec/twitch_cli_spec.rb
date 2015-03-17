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

    let(:client) { double({
      :get_games => {"top" => games},
      :get_streams => {"streams" => streams}
    })}

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

    it "lists the games being streamed" do
      games.each do |g|
        expect(shell).to receive(:say).with("#{App.game_to_str(g)}")
      end

      App.start(["games"], :shell => shell)
    end

    it "lists streams under a game" do
      streams.each do |s|
        expect(shell).to receive(:say).with("#{App.stream_to_str(s)}")
      end

      App.start(["streams", "some_game"], :shell => shell)
    end
  end
end
