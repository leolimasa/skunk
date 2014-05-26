require 'test/unit'
require 'skunk/core/artifact'

module Skunk
	module Core
		class TestArtifact < Test::Unit::TestCase
			def test_hash
				art1 = Artifact.new
				art2 = Artifact.new
				art3 = Artifact.new

				art1.name = "art1"
				art1.version = "1.0"
				art1.group = "group1"

				art2.name = "art1"
				art2.version = "1.0"
				art2.group = "group1"

				art3.name = "art1"
				art3.version = "2.0"
				art3.group = "group1"


				assert_equal(art1.hash, art2.hash)
				assert_not_equal(art1.hash, art3.hash)
			end
		end
	end
end

				

