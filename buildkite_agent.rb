dep "buildkite-agent" do
  requires "buildkite-agent.managed"
  requires "buildkite-agent.launchctl"
end

dep "buildkite-agent.managed", :buildkite_token do
  requires "homebrew tap".with "buildkite/buildkite"

  met? {
    shell("brew list").include?("buildkite-agent")
  }

  meet {
    shell("brew install --devel --token='#{buildkite_token}' buildkite-agent")
  }

  provides "buildkite-agent"
end

dep "buildkite-agent.launchctl", template: "launchctl" do
  requires "buildkite-agent.managed"
  service "buildkite-agent"
end
