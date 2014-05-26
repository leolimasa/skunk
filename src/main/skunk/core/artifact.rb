require 'digest/sha1'

module Skunk
	module Core
		class Artifact
			attr_accessor :group, :name, :version

			def initialize
				@group = ""
				@name = ""
				@version = ""
			end

			# Generates a number which uniquely identifies a combination of 
			# group, name, and version. This can be used to compare if two
			# artifact object instances have the same group, name, and version
			# parameters.
			def hash
				return Digest::SHA1.hexdigest "#{@group}#{@name}#{@version}"
			end

			# A string representation of the artifact, to use when displaying
			# messages
			def as_str
				return "#{@group}.#{@name}:#{@version}"
			end
			
		end
	end
end