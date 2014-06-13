# From https://github.com/bradfeehan/babushka-deps

# Ensures a Git repository exists and is up-to-date
#
#   * path:      The path to where the repository should be found
#   * url:       The URL to clone the repository from if it doesn't
#                exist at the path
#   * branch:    The branch to ensure is check out
dep 'repository', :path, :url, :branch, :template => 'repo' do
  requires 'exists.repo'.with(path, url),
           'branch.repo'.with(path, branch),
           'up-to-date.repo'.with(path)
end

# This meta-dep is more like helpful mixins for Git repositories
meta :repo do
  # Retrieves the GitRepo for the dep
  def repo
    Babushka::GitRepo.new path
  end

  def update_submodules
    log "Updating git submodules for git repo at #{path}" do
      repo.repo_shell 'git submodule update --init', :log => true
    end
  end
end

# Creates a new Git repository with nothing in it
#
#   path:    The path to the directory to create the repository in
#            (will be created if it doesn't exist)
#   options: A String with any command-line options to use (optional)
dep 'created.repo', :path, :options, :template => 'repo' do
  met? { repo.exists? }
  meet {
    log_block "Creating Git repository at #{path}" do
      require 'shellwords'
      shell! "git init #{options} #{Shellwords.escape(path.p)}"
    end
  }
end

# Ensures a repository exists, cloning it if it doesn't
#
#   path:      The path where the repository should exist
#   url:       The URL to clone the repository from if it doesn't exist
#              (optional, but the dep will be unmeetable when omitted)
dep 'exists.repo', :path, :url do
  met? { repo.exists? }
  meet { git url, :to => path }
  after { update_submodules }

  prepare {
    unmeetable! "No repo at #{path}, no URL given" unless url.set?
  }
end

dep 'fetched.repo', :path do
  requires 'exists.repo'.with(:path => path)
  met? {
    log "Fetching Git repository at #{path}" do
      repo.repo_shell? 'git fetch --all', :log => true
    end
  }

  meet {
    unmeetable! <<-END.gsub(/ {6}/, "")
      Error fetching Git repository at #{path}.
      Check that "git fetch --all" works in #{path}, before continuing.
    END
  }
end

# Ensures a repository has a particular branch checked out
#
#   path:   The path to the repository
#   branch: The name of the branch to check out
dep 'branch.repo', :path, :branch do
  requires 'fetched.repo'.with(:path => path)

  met? {
    if repo.clean?
      repo.current_branch == branch
    else
      message = "Dirty work tree at #{path}, not touching"
      true.tap { log_warn message.colorize 'yellow' }
    end
  }

  meet { repo.checkout! branch }
  after { update_submodules }
end

# Ensures a repository is up-to-date (not behind its upstream branch)
#
#   path:   The path to the repository
dep 'up-to-date.repo', :path do
  requires 'fetched.repo'.with(:path => path)

  met? {
    if repo.clean?
      !repo.behind?
    else
      message = "Not pulling from remote due to dirty work tree at #{path}"
      true.tap { log_warn message.colorize 'yellow' }
    end
  }

  meet { repo.reset_hard! "origin/#{repo.current_branch}" }
  after { update_submodules }
end
