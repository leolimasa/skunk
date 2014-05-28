require 'skunk/core/package'

module Skunk
	module Core

		# The current package that is being built
		class Project < Package

			attr_accessor :repositories
			attr_accessor :working_repository
			attr_accessor :installed_packages
      attr_accessor :install_transitive_dependencies

      # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

			def initialize
				@repositories = []
				@working_repository = nil
				@installed_packages = Hash.new
        @dependencies = []
        @install_transitive_dependencies = true
      end

      # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
			
			# Searches all the repositories for the specified artifact, and,
			# if found, installs it into the working repository.
			def install_dependency(artifact)
        return install_single_dependency(artifact, [])
      end

      # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

      def install_single_dependency(artifact, dependency_stack)

        # Check if the artifact is anywhere in the dependency stack, so that we
        # don't run into infinite loops
        for d in dependency_stack
          if d.hash == artifact.hash
            return
          end
        end

        # Don't install something that was already installed or is in the working repo
        if artifact_installed?(artifact)
          return @installed_packages[artifact.hash]
        end
        if @working_repository.check(artifact)
          return @working_repository.get_package_for(artifact)
        end

        repo = get_repository_for(artifact)

        # Install the transitive dependencies
        if install_transitive_dependencies
          dependency_stack.push(artifact)
          for d in repo.dependencies_for(artifact)
            install_single_dependency(d, dependency_stack)
          end
          dependency_stack.pop()
        end

        # Finally, install the artifact
        pkg = @working_repository.create_empty_package(artifact)
        repo.inflate_package(pkg)
        @working_repository.install_package(pkg)
        @installed_packages[pkg.hash] = pkg
        return pkg
      end

      # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

      # Whether the specified artifact/package has been installed or any_number_of_times
      def artifact_installed?(artifact)
        return @installed_packages.has_key?(artifact.hash)
      end

      # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

      # Returns the first repository that contains the specified artifact
      def get_repository_for(artifact)
        repo = nil
        @repositories.each do |r|
          if artifact.exists_in(r)
            repo = r
            break
          end
        end
        if repo == nil
          raise "Artifact not found in any repository: #{artifact.as_str}"
        end
        return repo
      end

      # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

      # Goes through the dependencies array and installs each one into the
      # working repository
      def install_dependencies
        @dependencies.each { |d| install_dependency(d)}
      end
    end
	end
end