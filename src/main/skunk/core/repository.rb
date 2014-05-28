module Skunk
	module Core

		# Base class for any repository
		class Repository

			# Abstract. Checks if the specified artifact exists in the 
			# repository
			def check(artifact)
				raise "check() not implemented."
			end

			# Abstract. Installs (upload, copy...) the contents of 
			# package.folder to the repository
			def install_package(package)
				raise "package() not implemented"
			end

			# Abstract. Initializes an empty package folder according to the
			# repository standards, taking into consideration the package name,
			# version, and group. The package.folder variable will be set.
			def create_empty_package(package)
				raise "create_empty_package() not implemented"
      end

      # Abstract. Creates a new package object given an artifact
      def get_package_from(artifact)
        raise "get_package_from() not implemented"
      end

			# Abstract. Downloads and fills the folder specified by 
			# package.folder with contents. Will also fill the package's 
			# dependencies list with information retrieved from the repository.
			def inflate_package(package)
				raise "inflate_package() not implemented"
			end

      # Abstract. Returns an array of all the dependencies for an artifact.
      def dependencies_for(artifact)
        raise "dependencies_for() not implemented"
      end
		end
	end
end