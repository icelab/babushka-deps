# Icelab Development Environment

[Babushka](http://babushka.me) deps for building the standard Icelab Mac OS X development environment.

## Install

Install babushka:

```sh
sh -c "`curl https://babushka.me/up`"
```

If you're running this for the very first time, first prepare the environment:

```sh
babushka "icelab:workstation bootstrapped"
```

Then afterwards, finish installing the environment:

```sh
babushka "icelab:workstation"
```

This command is all you'll need to run for any subsequent updates.

## Credits

Babushka is a wonderful automated computing system from [Ben Hoskings](http://github.com/benhoskings).

These deps are maintained by [Icelab](http://icelab.com.au/).
