# Managed services

dep "elasticsearch.managed" do
  requires "java.cask"
end

dep "memcached.managed"
dep "memcached.launchctl"

dep "mysql" do
  requires "mysql.managed"
  requires "mysql.launchctl"
  requires "mysql configured for low memory usage on OS X"
end
dep "mysql.managed"
dep "mysql.launchctl"
dep "mysql configured for low memory usage on OS X" do
  met? { "/usr/local/etc/my.cnf".p.exists? }

  meet {
    config = <<EOS
[mysqld]
max_connections       = 10

key_buffer_size       = 16K
max_allowed_packet    = 1M
table_open_cache      = 4
sort_buffer_size      = 64K
read_buffer_size      = 256K
read_rnd_buffer_size  = 256K
net_buffer_length     = 2K
thread_stack          = 128K
EOS

    shell "echo '#{config}' > /usr/local/etc/my.cnf"
  }

  after {
    shell "brew services restart mysql"
  }
end

dep "postgresql.managed" do
  provides "psql"
end
dep "postgresql.launchctl"

dep "redis.managed" do
  provides %w(redis-cli redis-server)
end
dep "redis.launchctl"

dep "elasticsearch.managed" do
  provides "elasticsearch"
end
dep "elasticsearch.launchctl"

# Managed packages

dep "docker.cask"

dep "heroku.managed" do
  provides "heroku"
end

dep "imagemagick.managed" do
  provides %w(compare animate convert composite conjure import identify stream display montage mogrify)
end

dep "java.cask"

dep "phantomjs.managed"

dep "rcm.managed" do
  requires_when_unmet "homebrew tap".with "thoughtbot/formulae"
  provides "rcup"

  met? {
    # Adjust `met?` block to skip checking package installation and simply look
    # for the executable in the path. This allows other users of these deps to
    # choose to install rcm from source.
    #
    # The reason to add this is because rcm has a very slow release cycle, and
    # (as of 2017-07-22), there are some helpful bugfixes around hamdling file
    # names with spaces that exist only in git master.
    in_path?(provides)
  }
end

dep "watch.managed"

# Gems

dep "git-smart.gem" do
  provides %w(git-smart-log git-smart-merge git-smart-pull)
end
dep "raygun.gem" do
  provides "raygun"
end
