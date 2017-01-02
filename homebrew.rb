# From https://github.com/bradfeehan/babushka-deps

# Ensures a particular Homebrew tap has been "tapped"
#
# Homebrew "taps" are like a repository of formulae (instructions used by
# Homebrew to install software). This dep ensures a particular tap has been
# added to Homebrew.
dep "homebrew tap", :tap_name do
  requires "homebrew"

  # Retrieves a list of all existing (tapped) taps
  #
  # This function returns an array, where each element is a string containing
  # the name of a tap that is currently tapped.
  def taps
    shell!("brew tap").strip.lines.map(&:strip)
  end

  met? { taps.include? tap_name.to_s }
  meet {
    log_block "Tapping Homebrew tap '#{tap_name}'" do
      shell! 'brew', 'tap', tap_name.to_s
    end
  }
end

# Bring back the `homebrew services` subcommand. See
# https://github.com/Homebrew/homebrew/issues/28657 for notes on its removal
# from core. We may need to track this for a little while in case the
# continued development moves elsewhere.
dep "homebrew services" do
  requires "homebrew tap".with "homebrew/services"
end
