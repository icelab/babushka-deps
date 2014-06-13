# Managed services

dep "postgresql.managed" do
  provides "psql"
end
dep "postgresql.launchctl"

dep "elasticsearch.managed"
dep "elasticsearch.launchctl"

dep "redis.managed" do
  provides %w(redis-cli redis-server)
end
dep "redis.launchctl"

# Managed packages

dep "heroku-toolbelt.managed" do
  provides "heroku"
end
dep "imagemagick.managed" do
  provides %w(compare animate convert composite conjure import identify stream display montage mogrify)
end
dep "phantomjs.managed"
dep "watch.managed"

# Gems

dep "git-smart.gem" do
  provides %w(git-smart-log git-smart-merge git-smart-pull)
end
dep "raygun.gem" do
  provides "raygun"
end
