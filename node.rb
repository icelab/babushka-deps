dep "nodenv" do
  requires "repository".with  :path => "~/.nodenv",
                              :url => "https://github.com/OiNutter/nodenv.git",
                              :branch => "master"

  requires "repository".with  :path => "~/.nodenv/plugins/node-build",
                              :url => "https://github.com/OiNutter/node-build.git",
                              :branch => "master"
end

meta :nodenv do
  accepts_value_for :version, :basename

  template {
    requires "nodenv"

    met? {
      shell("nodenv versions")[/#{version}\b/]
    }

    meet {
      log_shell "Installing node #{version}", "nodenv install #{version}"
    }
  }
end

dep "0.10.32.nodenv"

dep "set nodenv global version", :template => "task" do
  run {
    shell "nodenv global 0.10.32"
  }
end

dep "coffee-script.npm"
