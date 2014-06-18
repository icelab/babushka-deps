dep "icelab dotfiles" do
  requires "rcm.managed"
  requires "repository".with  :path => "~/.dotfiles-icelab",
                              :url => "https://github.com/icelab/dotfiles.git",
                              :branch => "master"

  met? {
    "~/.dotfiles-icelab".p.exists?
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
