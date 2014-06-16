# From https://github.com/bradfeehan/babushka-deps

# Bootstraps a "project"
#
# Each "project" uses a common pattern of a Git repository, containing
# a directory full of Babushka deps to set up the project. This
# template ensures that the project's repository is cloned. It then
# handles running the project's root-level babushka dep, in another
# dep Source (to keep the general-purpose deps and the project-specific
# deps separate).
#
#   url:      The URL of the Git repository (optional, but if not
#             provided and a Git repository doesn't exist at path, the
#             dep will be unmeetable as it doesn't know how to create
#             the repo)
#   path:     The path to the directory where the project will be
#             stored (optional, defaults to "~/src/foo", where "foo"
#             is the base name of the dep)
#   branch:   The branch that should be checked out in the project
#             (optional, defaults to "master")
#   dep_dir:  The name of the directory, relative to the root of the
#             project, containing the Babushka deps for the project
#             (optional, defaults to "babushka-deps")
#   dep_name: The name of the main babushka dep to run inside the
#             project to set it up (optional, no setup is performed if
#             omitted)
meta :project do
  accepts_value_for :url
  accepts_value_for :path, :default_path
  accepts_value_for :branch, 'master'
  accepts_list_for :dep_dir, 'babushka-deps'
  accepts_list_for :dep_name

  # The default path of the project repository
  #
  # The default path is constructed from the base name of the dep.
  def default_path
    "~/src/#{basename}"
  end

  template {
    # Wrap requires in setup block, when parameters are available
    setup {
      requires "repository".with({
        :path => path,
        :url => url,
        :branch => branch,
      })
    }

    # Gets the Git repository for the project
    def repo
      @repo ||= Babushka::GitRepo.new path
    end

    # Filters the "dep_dir" parameter to only those that actually exist
    #
    # Will also log warnings for any that are filtered out if they
    # can't be found.
    def existent_dep_dirs
      @existent_dep_dirs ||= dep_dir.map { |dir|
        (path.p / dir).tap do |result|
          if !result.exists?
            message = "Skipping missing dep source #{path.p / dir}"
            nil.tap { log_warn message.colorize 'yellow' }
          end
        end
      }.compact
    end

    # Creates an array of Sources, one for each dep_dir
    def sources
      @sources ||= existent_dep_dirs.map do |dir|
        Babushka::Source.new(dir).tap(&:load_deps!)
      end
    end

    # Searches all the sources for the dep specified in dep_name
    def dep_objects
      return nil if dep_name.nil?
      _deps = dep_name.map do |name|
        sources.pick { |source| source.find(name) }.tap do |result|
          unless result
            unmeetable! <<-END.gsub(/ {14}/, '')
              Couldn't find dep '#{name}' in project #{path.p}
              Looked in director#{dep_dir.count > 1 ? 'ies' : 'y'}:
              #{dep_dir.to_list}
            END
          end
        end
      end
    end

    met? {
      if !dep_name.any?
        debug "No dep specified for #{name}, not doing any project setup"
        true
      else
        # The project is set up if the "meet" block sets @success
        @success
      end
    }

    meet {
      if dep_objects.any?(&:nil?)
        missing = dep_objects.find(&:nil?)
        log "Couldn't find dep #{missing.name} in #{path.p / dir}"
      else
        # Process all deps and determine if they all succeeded
        log_warn 'We need to go deeper...'.colorize 'blue'
        debug "Running deps for project #{basename}".colorize 'blue'
        @success = dep_objects.all?(&:process)
      end
    }
  }
end
