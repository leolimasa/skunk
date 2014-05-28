require 'skunk/core/repository'
require 'skunk/core/package'

module Skunk
	module Core
		module Dummies
			class DummyRepository < Repository

				attr_accessor :check_artifact
				attr_accessor :install_package_artifact
				attr_accessor :create_empty_package_artifact
				attr_accessor :inflate_package_artifact
				attr_accessor :artifact_exists
				attr_accessor :package_folder
        attr_accessor :installed_packages
        attr_accessor :dependencies

				def initialize
					@check_artifact = nil
					@install_package_artifact = nil
					@create_empty_package_artifact = nil
					@inflate_package_artifact = nil
					@artifact_exists = true
					@package_folder = "/my/folder"
          @dependencies = []
          @installed_packages = []
				end

				def check(artifact)
					@check_artifact = artifact
					return @artifact_exists
				end

				def install_package(artifact)
					@install_package_artifact = artifact
          @installed_packages.push(artifact)
				end

				def create_empty_package(artifact)
					pkg = Package.new
					pkg.folder = @package_folder
          pkg.name = artifact.name
          pkg.group = artifact.group
          pkg.version = artifact.version
					@create_empty_package_artifact = artifact
          return pkg
        end

        def get_package_for(artifact)
          return create_empty_package(artifact)
        end

				def inflate_package(package)
					@inflate_package_artifact = package
        end

        def dependencies_for(artifact)
          return @dependencies
        end
			end
		end
	end
end