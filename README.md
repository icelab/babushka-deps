# Icelab Development Environment

[Babushka](http://babushka.me) deps for building the standard Icelab Mac OS X development environment.

## Requirements

* [macOS](http://www.apple.com/macos/sierra/) (10.12 Sierra or 10.11 El Capitan)
* Latest available version of [Xcode](https://developer.apple.com/xcode/)

## Install

### First time

First, if this is not a fresh machine, [prepare your system](docs/preparing-your-system.md). You must follow these steps if you have an existing Homebrew installation, Ruby or Node.js version managers, or custom dotfiles in your home directory. **After you've done this, open a new shell.**

Install Babushka:

```sh
sh -c "`curl https://babushka.me/up`"
```

You'll be asked where to install Babushka. Accept the default value of `/usr/local/babushka`.

Then, apply our Babushka deps. If you're running this for the very first time, you need to apply a bootstrapping dep first:

```sh
babushka "icelab:workstation bootstrapped"
```

You'll be prompted for some things:

1. To enter your user password.
2. To enable write access to `/usr/local` for admin users.

It's OK to comply with both of these.

After this has completed, _**open a new shell**_ and then finish applying the rest of the deps:

```sh
babushka "icelab:workstation"
```

### Updates

To update your environment, first update the Babushka sources:

```sh
babushka sources -u
```

Then apply our deps again:

```sh
babushka "icelab:workstation"
```

## What it sets up

These Babushka deps aren't magic. They're merely a collection of jobs that bring your system environment to a known state by installing things and running shell commands.

This means the resulting environment isn't all that special; it's a vanilla macOS web development environment. You should endeavour to understand and learn the tools that are installed so you can work with them directly after they are in place.

### Your environment

[Zsh](http://www.zsh.org) is your default shell, and the [Icelab dotfiles](https://github.com/icelab/dotfiles) provide a common shell environment. These are managed using [rcm](http://thoughtbot.github.io/rcm/) and can be combined with another dotfiles directory for personal customization. See the [README](https://github.com/icelab/dotfiles) for more information.

[rbenv](https://github.com/sstephenson/rbenv) and [ruby-build](https://github.com/sstephenson/ruby-build) manage and install your Ruby versions. The most recent stable Ruby version is your default.

[nodenv](https://github.com/nodenv/nodenv) and [node-build](https://github.com/nodenv/node-build) for managing and installing Node.js versions. The most recent stable Node.js version is your default.

### Your system

[Homebrew](http://brew.sh) is installed in `/usr/local` for installing and managing system packages.

The following system services are installed via Homebrew and already running:

* [Memcached](http://memcached.org) memory object caching system
* [MySQL](http://www.mysql.com) relational database
* [PostgreSQL](http://www.postgresql.org) relational database
* [Redis](http://redis.io) key-value cache and store

The `brew services` command is available for managing these services (run `brew help services` for more information).

These utilities are also installed:

* [CoffeeScript](http://coffeescript.org)
* [Heroku CLI](https://github.com/heroku/heroku) for working with [Heroku](http://heroku.com) apps
* [ImageMagick](http://www.imagemagick.org) image processing utilities
* [PhantomJS](http://phantomjs.org) headless web browser, for web app integration testing
* [Raygun](https://github.com/carbonfive/raygun) for generating new appss
* Plus various helpful Unix utilities, including `watch(1)`

## Customize your environment with Babushka

If you want to automate your personal system customizations, you can write your own Babushka deps and have them work alongside these ones.

First, make sure you have a space for your personal Babushka source:

```sh
mkdir -p ~/.babushka/deps
```

Then create a dep that requires icelab:workstation, along with any other personal deps that you'd like to use, e.g. in `~/.babushka/deps/laptop.rb`:

```ruby
dep "laptop" do
  # Build the standard Icelab environment
  requires "icelab:workstation"

  ### Personal deps can follow

  # I prefer wget
  requires "wget.managed"
end

dep "wget.managed"
```

Then, running `babushka laptop` will ensure the Icelab development environment stays updated alongside all of your customizations.

To share your deps, turn `~/.babushka/deps` into a git repo and push it up to `https://github.com/<your_username>/babushka-deps.git`. See [Tim's Babushka deps](https://github.com/timriley/babushka-deps) as an example.

## Credits

Babushka is a wonderful automated computing system from [Ben Hoskings](http://github.com/benhoskings).

These deps are maintained by [Icelab](http://icelab.com.au/).
