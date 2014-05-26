require 'skunk/core/artifact'

module Skunk
	module Core

		# A Package is an artifact that has its files in a folder. It also
		# stores dependency information.
		class Package < Artifact

			attr_accessor :folder, :dependencies

			def initialize
				@folder = ""
				@dependencies = []
			end
		end
	end
end