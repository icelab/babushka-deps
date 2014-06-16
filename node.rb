dep "nodenv", :template => "managed"

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

dep "v0.10.28.nodenv"

dep "set nodenv global version", :template => "task" do
  run {
    shell "nodenv global v0.10.28"
  }
end

dep "coffee-script.npm"
