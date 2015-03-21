# twitch_cli
A CLI to list the online streams on Twitch.

## Usage
```
Commands:
  twitch_cli games           # lists the games being streamed
  twitch_cli help [COMMAND]  # Describe available commands or one specific command
  twitch_cli streams [GAME]  # list the online users streaming [GAME]

Options:
  [--config=FILE]        # Use this YAML configuration file
                         # Default: ~/.twitch_cli
  [--more], [--no-more]  # fetch multiple pages
```

You can set a default game for the `streams` command in the configuration file:

```
game: 'StarCraft II: Heart of the Swarm'
```

The name of the game must match the one returned by the `games` command.

But you can configure aliases to each game:

```
alias:
  csgo: 'Counter-Strike: Global Offensive'
  sc2: 'StarCraft II: Heart of the Swarm'
```

