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
      log_shell "Updating rubygems",  "RBENV_VERSION=#{version} gem update --system"
      log_shell "Installing bundler", "RBENV_VERSION=#{version} gem install bundler"
    }
  }
end

dep "ruby 2.1.2", template: "rbenv" do
  version "2.1.2"
end

dep "global ruby version", :version do
  requires "rbenv"

  met? {
    shell("rbenv global") == version
  }

  meet {
    shell "rbenv global #{version}"
  }
end
