module TwitchCli
  class Configuration
    def self.setup filename
      if File.exist?(filename)
        File.readlines(filename).inject({}) do |conf, line|
          key,value = line.chomp.split("=")
          conf[key] = value unless key.nil?
          conf
        end
      else
        {}
      end
    end
  end
end
