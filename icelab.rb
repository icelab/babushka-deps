dep "workstation" do
  # Databases
  requires "postgresql.managed"
  requires "redis.managed"

  # General homebrew packages
  requires "elasticsearch.managed"
  requires "imagemagick.managed"
  requires "watch.managed"
  requires "heroku-toolbelt.managed"
  requires "phantomjs.managed"

  # Ruby
  requires "2.1.2.rbenv"
  requires "set rbenv global version"
  # requires "rubygems system up to date"
  requires "bundler.gem"

  # Global gems
  requires "git-smart.gem"
  requires "raygun.gem"

  # Node
  requires "v0.10.28.nodenv"
  requires "set nodenv global version"

  # Global node packages
  requires "coffee-script.npm"

  # Services
  requires "postgresql.launchctl"
  requires "redis.launchctl"
  requires "elasticsearch.launchctl"
end
