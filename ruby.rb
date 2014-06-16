dep "rbenv", :template => "managed"
dep "rbenv-gem-rehash", :template => "managed" do
  provides []
end
dep "ruby-build", :template => "managed"

meta :rbenv do
  accepts_value_for :version, :basename

  template {
    requires "icelab:rbenv", "icelab:rbenv-gem-rehash", "icelab:ruby-build"

    met? {
      shell("rbenv versions")[/#{version}\b/]
    }

    meet {
      log_shell "Installing ruby #{version}", "rbenv install #{version}"
    }
  }
end

dep "2.1.2.rbenv"

dep "set rbenv global version", :template => "task" do
  run {
    shell "rbenv global 2.1.2"
  }
end

dep "bundler.gem" do
  provides "bundle"

  # TODO: support configuration for default multi-core bundler
  # fancy_echo "Configuring Bundler for faster, parallel gem installation ..."
  # number_of_cores=$(sysctl -n hw.ncpu)
  # bundle config --global jobs $((number_of_cores - 1))
end

dep "rubygems system up to date", :template => "task" do
  run {
    shell "gem update --system"
  }
end
