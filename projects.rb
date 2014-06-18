dep "projects" do
  requires "repository".with :path => "~/.babushka/sources/projects",
                             :url => "git@bitbucket.org:icelab/babushka-project-deps.git",
                             :branch => "master"
end
