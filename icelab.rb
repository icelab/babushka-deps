dep "workstation" do
  # Databases
  requires "elasticsearch.managed"
  requires "elasticsearch.launchctl"

  requires "memcached.managed"
  requires "memcached.launchctl"

  requires "mysql.managed"
  requires "mysql.launchctl"

  requires "postgresql.managed"
  requires "postgresql.launchctl"

  requires "redis.managed"
  requires "redis.launchctl"

  # General homebrew packages
  requires "imagemagick.managed"
  requires "watch.managed"
  requires "heroku-toolbelt.managed"
  requires "phantomjs.managed"

  # Ruby
  requires "ruby 2.1.2"
  requires "global ruby version".with "2.1.2"

  # Global gems
  requires "git-smart.gem"
  requires "raygun.gem"

  # Node
  requires "v0.10.28.nodenv"
  requires "set nodenv global version"

  # Global node packages
  requires "coffee-script.npm"

  # Shell
  requires "shell".with :shell_name => "zsh"

  # Dotfiles
  requires "dotfiles"

  # Projects source
  requires "projects"
end
