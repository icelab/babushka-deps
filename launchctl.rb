meta :launchctl do
  accepts_value_for :service, :basename

  def qualified_service_name
    "homebrew.mxcl.#{service}"
  end

  def service_dir
    "/usr/local/opt/#{service}".p
  end

  def plist_path
    "#{service_dir}/#{qualified_service_name}.plist".p
  end

  template {
    met? {
      if plist_path.exists?
        shell?("launchctl list #{qualified_service_name}")
      else
        true # If the service isn't installed, don't try and start it.
      end
    }

    meet {
      shell "mkdir -p ~/Library/LaunchAgents"
      shell "ln -sfv #{plist_path} ~/Library/LaunchAgents/"
      shell "launchctl load -w ~/Library/LaunchAgents/#{File.basename(plist_path)}"
    }
  }
end
