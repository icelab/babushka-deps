# 2014-11-06: The homebrew formula for phantomjs was updated to work with OS X
# Yosemite. We no longer need to download it directly.
dep "direct phantomjs binary download removed" do
  met? {
    !Babushka.host.pkg_helper.has?("phantomjs") && "/usr/local/bin/phantomjs".p.exists?
  }

  meet {
    shell "rm /usr/local/bin/phantomjs"
  }
end
