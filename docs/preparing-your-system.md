# Preparing an existing system

The easiest way to make sure your system accepts the development environment is to prepare a clean slate.

Before you follow any of these instructions, _understand what they are doing_. They will remove things from your system. If there is anything that you want to record about the state of your system (e.g. a list of installed Homebrew packages or Ruby gems), do this now.

## Move aside conflicting dotfiles

Some [shared dotfiles](https://github.com/icelab/dotfiles) will be installed. Move yours aside to let these come into place.

```sh
shared_dotfiles=(aliases gemrc gitconfig gitignore gitmessage psqlrc rcrc rspec zsh zshenv zshrc)

for dotfile in ${shared_dotfiles[*]}; do
  if [ -e ~/.${dotfile} ]; then
    echo "Moving ~/.$dotfile to ~/.$dotfile.pre-icelab-babushka-deps"
    mv ~/.${dotfile} ~/.${dotfile}.pre-icelab-babushka-deps
  fi
done
```

Once the development environment is installed, you can learn how to [extend, customize or even replace these dotfiles](https://github.com/icelab/dotfiles).

You should do at least one other thing before installing the new environment: create a `~/.gitconfig.local` file with your personal name and email address for git commits, e.g.

```
[user]
  name = Your Name
  email = your@email.com
```

This file will get automatically picked up and used by the new dotfiles that are installed.

## Uninstall rbenv and nodenv

These version managers are installed into your home directory. Remove any you might already have in place.

```sh
rm -rf ~/.rbenv
rm -rf ~/.nodenv
```

If you are using other version managers, like chruby, rvm or nvm, you should remove them too.

## Uninstall homebrew

_(These uninstall instructions are based on [mxcl's gist](https://gist.github.com/mxcl/1173223))_

Before you try and remove Homebrew, make sure you have it's already installed already:

```sh
brew --prefix
```

If this doesn't return a path, you don't need to do anything else. If it does, carry on with these instructions. You can paste them line-by-line into your terminal. They'll remove all the Homebrew-related files from your system (typically from `/usr/local`), and leave anything else in place.

After you've done this, it might be a good time to poke around that part of the filesystem and see if there's anything else you'd like to clean up.

```sh
cd `brew --prefix`
git checkout master
rm -rf Cellar
bin/brew prune
git ls-files -z | xargs -0 rm
rm -rf Library/Homebrew Library/Aliases Library/Formula Library/Contributions Library/Taps Library/LinkedKegs Library/ENV

for file in `find opt -type l 2>/dev/null`; do
  if [ `readlink $file | egrep '^\.\./Cellar'` ]; then
    rm $file
  fi
done

rmdir -p bin Library opt share/man/man1 2> /dev/null
rm -rf .git
rm -rf ~/Library/Caches/Homebrew
rm -rf ~/Library/Logs/Homebrew
rm -rf /Library/Caches/Homebrew
```
