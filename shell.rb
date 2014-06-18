# Sets the shell to use for a particular user
#
#   * username:   Determines which user's shell should be changed
#                 (optional, defaults to the current user)
#   * shell_name: Path to the binary to use for their shell
dep 'shell', :username, :shell_name do
  username.default! current_username

  # Finds the full path of the shell specified in "shell"
  def shell_path
    value = shell_name.to_s

    if value.match(/^\//)
      # Absolute path already provided (starts with "/")
      value.p
    else
      # Shell name provided, use "which" to find the executable
      which(value).p
    end
  end

  setup {
    require 'shellwords'
    requires 'shell in database'.with(shell_path)
  }

  met? {
    command = "su - #{Shellwords.escape(username)} -c 'echo $SHELL'"
    shell!(command, :sudo => true).strip == shell_path
  }

  meet {
    shell! "chsh -s #{Shellwords.escape(shell_path)}", :sudo => username
  }
end

# Ensures a particular shell is setup in /etc/shells
#
#   * shell_path: The full path to a shell to use (optional, will be
#                 determined using shell_name if omitted)
dep 'shell in database', :shell_path do
  met? { '/etc/shells'.p.grep(shell_path) }
  meet {
    require 'shellwords'
    log "Adding '#{shell_path}' to the shell database..."
    shell! "echo #{shell_path} >> /etc/shells", :sudo => true
  }
end
