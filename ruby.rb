dep "rbenv", :template => "managed"
dep "rbenv-gem-rehash", :template => "managed" do
  provides []
end
dep "ruby-build", :template => "managed"

meta :rbenv do
  accepts_value_for :version, :basename

  # In Yosemite, once gcc-4.2 is installed (needed for older rubies), MRI's
  # build scripts use it in preference to the default `gcc` binary, which
  # actually causes the builds to break. Specifying the standard gcc here
  # fixes this. See https://github.com/sstephenson/ruby-build/issues/651.
  #
  # TODO: it might be nice to have some sort of "dynamic" dependency here that
  # knows which version of GCC to use for which version of ruby.
  accepts_value_for :build_env_vars, "CC=/usr/bin/gcc"

  template {
    requires "icelab:rbenv", "icelab:rbenv-gem-rehash", "icelab:ruby-build"

    met? {
      shell("rbenv versions")[/#{version}\b/]
    }

    meet {
      log_shell "Installing ruby #{version}", "#{build_env_vars} rbenv install #{version}"
      log_shell "Updating rubygems",  "RBENV_VERSION=#{version} gem update --system"
      log_shell "Installing bundler", "RBENV_VERSION=#{version} gem install bundler"
    }
  }
end

dep "global ruby version", :version do
  requires "rbenv"

  met? {
    shell("rbenv global") == version
  }

  meet {
    shell "rbenv global #{version}"
  }
end

dep "ruby ree-1.8.7-2012.02", :template => "icelab:rbenv" do
  requires "apple-gcc42.managed" # For rubies older than 1.9.3-p125

  version "ree-1.8.7-2012.02"

  # Some tricks for compiling on Yosemite. See https://github.com/sstephenson/ruby-build/issues/654
  build_env_vars "CC=/usr/bin/gcc-4.2 MACOSX_DEPLOYMENT_TARGET=10.9"
end

dep "ruby 1.9.3-p448", :template => "rbenv" do
  version "1.9.3-p448"
end

dep "ruby 2.0.0-p576", :template => "rbenv" do
  version "2.0.0-p576"
end

dep "ruby 2.1.2", :template => "rbenv" do
  version "2.1.2"
end

dep "ruby 2.1.3", :template => "rbenv" do
  version "2.1.3"
end

dep "ruby 2.1.4", :template => "rbenv" do
  version "2.1.4"
end
