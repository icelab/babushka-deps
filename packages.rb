dep "docker.cask"

dep "heroku.managed" do
  provides "heroku"
end

dep "imagemagick.managed" do
  provides %w(compare animate convert composite conjure import identify stream display montage mogrify)
end

dep "overmind.managed"

dep "phantomjs.managed"

dep "rcm.managed" do
  # Add custom `met?` condition because the usual "brew info rcm" check will
  # fail here with 'Error: no available formula with the name "rcm"'
  met? { in_path? "rcup" }
  requires_when_unmet "homebrew tap".with "thoughtbot/formulae"
  provides "rcup"
end

# Gems

dep "git-smart.gem" do
  provides %w(git-smart-log git-smart-merge git-smart-pull)
end
dep "raygun.gem" do
  provides "raygun"
end
