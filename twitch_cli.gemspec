Gem::Specification.new do |s|
  s.name        = "twitch_cli"
  s.version     = "0.6.0"
  s.date        = "2015-03-16"
  s.summary     = "Twitch CLI"
  s.description = "A command-line interface to list the online streams on Twitch"
  s.authors     = ["Arthur Hirata"]
  s.email       = "arthur_hirata@yahoo.com.br"
  s.homepage    = "https://github.com/ahirata/twitch_cli"
  s.license       = "MIT"

  s.add_development_dependency "rspec", "~> 3.2", ">= 3.2.0"
  s.add_development_dependency "vcr", "~> 2.9.3", ">= 2.9.3"
  s.add_development_dependency "webmock", "~> 1.20.4", ">= 1.20.4"
  s.add_development_dependency "fakefs", "~> 0.6.7", ">= 0.6.7"

  s.add_runtime_dependency "httparty", "~> 0.13.3"
  s.add_runtime_dependency "thor", "~> 0.19.1"

  s.files       = ["lib/twitch_cli.rb", "lib/twitch_cli/client.rb"]
  s.executables << "twitch_cli"
end
