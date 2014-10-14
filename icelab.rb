dep "workstation environment" do
  # rbenv
  requires "icelab:rbenv", "icelab:rbenv-gem-rehash", "icelab:ruby-build"

  # nodenv
  requires "nodenv"

  # Dotfiles
  requires "dotfiles"

  # Shell
  requires "shell".with :shell_name => "zsh"
end

dep "workstation" do
  requires "workstation environment"

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
  requires "node 0.10.32"
  requires "global node version".with "0.10.32"

  # Global node packages
  requires "coffee-script.npm"

  # Projects source
  requires "projects"
end
