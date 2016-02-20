# A bootstrapping dep for first-time installs. This prepares the shell
# environment for the rest of the deps to run.
dep "workstation bootstrapped" do
  # Install the version managers
  requires "icelab:rbenv", "icelab:ruby-build"
  requires "nodenv"

  # Bring in the Icelab dotfiles, which includes zsh config to initialize the
  # version managers
  requires "dotfiles"

  # And set the shell to zsh, so this config can take effect
  requires "shell".with :shell_name => "zsh"

  after {
    message = word_wrap("The environment is bootstrapped. If this is your first installation, open a new shell and run \"babushka icelab:workstation\" to continue.")

    log "❄︎"*80,        :as => :warning
    log message,       :as => :warning
    log "❄︎"*79 + "☃",  :as => :warning
  }

  # Thanks, ActionView
  def word_wrap(text, options = {})
    line_width = options.fetch(:line_width, 80)

    text.split("\n").collect! do |line|
      line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip : line
    end * "\n"
  end
end

dep "workstation" do
  requires "workstation bootstrapped"

  requires "homebrew services"

  requires "memcached.managed"
  requires "memcached.launchctl"

  requires "mysql"

  requires "postgresql.managed"
  requires "postgresql.launchctl"
  requires "postgres fixed for yosemite"

  requires "redis.managed"
  requires "redis.launchctl"

  # General homebrew packages
  requires "imagemagick.managed"
  requires "watch.managed"
  requires "heroku-toolbelt.managed"
  requires "phantomjs.managed"

  # Ruby
  requires "ruby 2.2.3"
  requires "global ruby version".with "2.2.3"

  # Global gems
  requires "git-smart.gem"
  requires "raygun.gem"

  # Node
  requires "node 0.10.33"
  requires "global node version".with "0.10.33"

  # Global node packages
  requires "coffee-script.npm"
end
