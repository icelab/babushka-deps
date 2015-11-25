# Managed services

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

# Temporarily provide PhantomJS via an NPM package until the homebrew
# version works with El Capitan
# dep "phantomjs.managed" do
dep "phantomjs.npm" do
  requires "direct phantomjs binary download removed"
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
