dep "docker" do
  requires "dinghy setup"
  requires "docker-compose.managed"
end

dep "dinghy" do
  met? {
    in_path?("dinghy")
  }

  meet {
    log "Installing dinghy via brew" do
      shell(
        "brew install dinghy --HEAD https://github.com/codekitchen/dinghy/raw/latest/dinghy.rb",
        :sudo => Babushka::BrewHelper.should_sudo?,
        :log => true,
        :closing_status => :status_only
      )
    end
  }
end

dep "dinghy setup" do
  requires "virtualbox"
  requires "dinghy"

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
