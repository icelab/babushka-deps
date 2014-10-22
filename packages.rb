# Managed services

dep "memcached.managed"
dep "memcached.launchctl"

dep "mysql.managed"
dep "mysql.launchctl"

dep "postgresql.managed" do
  provides "psql"
end
dep "postgresql.launchctl"

dep "redis.managed" do
  provides %w(redis-cli redis-server)
end
dep "redis.launchctl"

# Managed packages

dep "apple-gcc42.managed" do # For building older rubies
  requires "homebrew tap".with "homebrew/dupes"
  provides "gcc-4.2"
end

dep "heroku-toolbelt.managed" do
  provides "heroku"
end

dep "imagemagick.managed" do
  provides %w(compare animate convert composite conjure import identify stream display montage mogrify)
end

dep "phantomjs" do
  met? {
    in_path? "phantomjs"
  }

  meet {
    Babushka::Resource.extract "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-macosx.zip" do |archive|
      shell "cp bin/phantomjs /usr/local/bin"
    end
  }
end

dep "rcm.managed" do
  requires "homebrew tap".with "thoughtbot/formulae"
  provides "rcup"
end

dep "watch.managed"

# Gems

dep "git-smart.gem" do
  provides %w(git-smart-log git-smart-merge git-smart-pull)
end
dep "raygun.gem" do
  provides "raygun"
end
