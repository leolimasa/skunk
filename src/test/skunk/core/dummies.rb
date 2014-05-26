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

				def initialize
					@check_artifact = nil
					@install_package_artifact = nil
					@create_empty_package_artifact = nil
					@inflate_package_artifact = nil
					@artifact_exists = true
					@package_folder = "/my/folder"
				end

				def check(artifact)
					@check_artifact = artifact
					return @artifact_exists
				end

				def install_package(artifact)
					@install_package_artifact = artifact
				end

				def create_empty_package(artifact)
					pkg = Package.new
					pkg.folder = @package_folder
					@create_empty_package_artifact = artifact
          return pkg
				end

				def inflate_package(package)
					@inflate_package_artifact = package
				end
			end
		end
	end
end