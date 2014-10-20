# Icelab Development Environment

[Babushka](http://babushka.me) deps for building the standard Icelab Mac OS X development environment.

## Prerequisites

* Mac OS X (10.9 Mavericks or 10.10 Yosemite)
* [Java](https://www.java.com/en/download/help/mac_install.xml)

## Install

### First time

First, [prepare your system](docs/preparing-your-system.md).

Install babushka:

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

## Credits

Babushka is a wonderful automated computing system from [Ben Hoskings](http://github.com/benhoskings).

These deps are maintained by [Icelab](http://icelab.com.au/).
