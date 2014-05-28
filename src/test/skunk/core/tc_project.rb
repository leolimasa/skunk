require 'test/unit'
require 'skunk/core/project'
require 'skunk/core/dummies'

module Skunk
	module Core
		class TestProject < Test::Unit::TestCase

      def setup
        @wrepo = Dummies::DummyRepository.new
        @repo = Dummies::DummyRepository.new
        @proj = Project.new
        @proj.working_repository = @wrepo
        @proj.repositories.push(@repo)
      end

			def test_install_dependency

				art = Artifact.new
				art.group = "group"
				art.name = "art"
				art.version = "1.0"

        @wrepo.artifact_exists = false
				pkg = @proj.install_dependency(art)
				assert_equal(@wrepo.install_package_artifact, pkg)
				assert_equal(pkg.folder, "/my/folder")
      end

      def test_install_dependency_not_available
        @repo.artifact_exists = false

        exception_thrown = false

        begin
          @proj.install_dependency(art)
        rescue
          exception_thrown = true
        end
        assert_equal(exception_thrown, true)
      end

      def test_install_dependency_transitive
        dep1 = Artifact.new
        dep1.name = "art1"

        dep2 = Artifact.new
        dep2.name = "art2"

        mainart = Artifact.new
        mainart.name = "main"

        @wrepo.artifact_exists = false
        @repo.dependencies = [dep1, dep2]
        @proj.install_dependency(mainart)

        has_dep1 = false
        has_dep2 = false
        has_main = false

        @proj.installed_packages.each do |p|
          case p[0]
            when dep1.hash
              has_dep1 = true
            when dep2.hash
              has_dep2 = true
            when mainart.hash
              has_main = true
          end
        end

        assert_equal(true, has_dep1)
        assert_equal(true, has_dep2)
        assert_equal(true, has_main)
      end
		end
	end
end