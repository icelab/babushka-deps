meta :subl_package do
  accepts_value_for :name, :basename
  accepts_value_for :source
  accepts_value_for :branch, "master"

  def package_name
    basename.sub(/\.subl_package$/, "")
  end

  def path
    "~/Library/Application Support/Sublime Text 3/Packages" / package_name
  end

  template {
    # requires "sublime-text3"

    # Wrap requires in setup block, when parameters are available
    setup {
      requires "icelab:repository".with :path => path,
                                        :url => source,
                                        :branch => branch
    }
  }
end
