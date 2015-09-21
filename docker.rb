dep "docker" do
  requires "dinghy setup"
  requires "docker-compose.managed"
end

dep "dinghy.managed" do
  met? {
    pkg_manager.has?("dinghy") && in_path?("dinghy")
  }

  meet {
    log "Installing dinghy via brew" do
      shell(
        "brew install dinghy --HEAD https://github.com/codekitchen/dinghy/raw/latest/dinghy.rb",
        :sudo => pkg_manager.should_sudo?,
        :log => true,
        :closing_status => :status_only
      )
    end
  }
end

dep "dinghy setup" do
  requires "virtualbox"
  requires "dinghy.managed"

  met? {
    vm_status = shell("dinghy status").split("\n").val_for("VM")
    vm_status.to_s != "" && vm_status != "not created"
  }

  meet {
    log_shell "Setting up dinghy VM", "dinghy create --provider virtualbox"
  }
end

dep "docker-compose.managed" do
  installs "fig"
  provides "docker-compose"
end
