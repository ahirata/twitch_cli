require 'twitch_cli'
require  'fakefs/spec_helpers'

module TwitchCli
  RSpec.describe Configuration do
    include FakeFS::SpecHelpers
    it "read a hash from the filename" do
      File.open("configfile", "w") do |f|
        f.puts("key1=value1")
        f.puts("key2=value2")
      end

      config = Configuration.setup("configfile")

      expect(config["key1"]).to eql("value1")
      expect(config["key2"]).to eql("value2")
      expect(config.length).to eql(2)
    end

    it "discards empty lines" do
      File.open("configfile", "w") do |f|
        f.puts("key1=value1")
        f.puts("key2=value2")
        f.puts("")
      end

      config = Configuration.setup("configfile")

      expect(config["key1"]).to eql("value1")
      expect(config["key2"]).to eql("value2")
      expect(config.length).to eql(2)
    end

    it "discards blank lines" do
      File.open("configfile", "w") do |f|
        f.puts("key1=value1")
        f.puts("  ")
        f.puts("key2=value2")
      end

      config = Configuration.setup("configfile")

      expect(config["key1"]).to eql("value1")
      expect(config["key2"]).to eql("value2")
      expect(config.length).to eql(2)
    end

  end
end

