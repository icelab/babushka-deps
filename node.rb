dep "nodenv", :template => "managed"

dep "node-build", :template => "managed"

dep "yarn", :template => "managed"

meta :nodenv do
  accepts_value_for :version, :basename

  template {
    requires "icelab:nodenv"

    met? {
      shell("nodenv versions || true")[/#{version}\b/]
    }

    meet {
      log_shell "Installing node #{version}", "nodenv install #{version}"
    }

    after {
      log_shell "nodenv rehash", "nodenv rehash"
    }
  }
end

dep "node 6.10.0", :template => "nodenv" do
  version "6.10.0"
end

dep "global node version", :version do
  requires "nodenv"

  met? {
    shell("nodenv global") == version
  }

  meet {
    shell "nodenv global #{version}"
  }

  after {
    log_shell "nodenv rehash", "nodenv rehash"
  }
end

dep "coffee-script.npm"
