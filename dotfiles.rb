dep "icelab dotfiles" do
  requires "rcm.managed"
  requires "repository".with  :path => "~/.dotfiles-icelab",
                              :url => "https://github.com/icelab/dotfiles.git",
                              :branch => "master"

  met? {
    # Require that the dotfiles repository is checked out _and_ installed (by checking just one dotfile)
    "~/.dotfiles-icelab".p.exists? && (zshrc = "~/.zshrc".p).symlink? && zshrc.readlink == "~/.dotfiles-icelab/zshrc".p
  }

  after {
    shell "rcup -d ~/.dotfiles-icelab -x README.md -x LICENSE"
  }
end

dep "dotfiles", :template => "task" do
  requires "icelab dotfiles"

  run {
    shell "rcup"
  }
end
