module TwitchCli
  class Configuration
    def self.setup filename
      File.exist?(filename) ? read_file(filename) : {}
    end

    def self.read_file filename
      File.readlines(filename).inject({}) do |conf, line|
        conf.merge!(Hash[*line.strip.split("=")])
      end
    end
  end
end
