require 'skunk/core/package'

module Skunk
	module Core

		# The current package that is being built
		class Project < Package

			attr_accessor :repositories
			attr_accessor :working_repository
			attr_accessor :installed_packages

			def initialize
				@repositories = []
				@working_repository = nil
				@installed_packages = Hash.new
			end
			
			# Searchs all the repositories for the specified artifact, and,
			# if found, installs it into the working repository.
			def install_dependency(artifact)
				for r in repositories
					if not r.check(artifact)
						next
					end

					pkg = @working_repository.create_empty_package(artifact)
					r.inflate_package(pkg)
					@working_repository.install_package(pkg)

					return pkg
				end

				raise "Artifact not found in any repository: #{artifact.as_str}"
			end
		end
	end
end