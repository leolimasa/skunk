require 'test/unit'
require 'skunk/core/project'
require 'skunk/core/dummies'

module Skunk
	module Core
		class TestProject < Test::Unit::TestCase

			def test_install_dependency
				wrepo = Dummies::DummyRepository.new
				repo = Dummies::DummyRepository.new
				proj = Project.new

				proj.working_repository = wrepo
				proj.repositories.push(repo)

				art = Artifact.new
				art.group = "group"
				art.name = "art"
				art.version = "1.0"

				pkg = proj.install_dependency(art)
				assert_equal(wrepo.install_package_artifact, pkg)
				assert_equal(pkg.folder, "/my/folder")

        repo.artifact_exists = false
        exception_thrown = false

        begin
          proj.install_dependency(art)
        rescue
          exception_thrown = true
        end
        assert_equal(exception_thrown, true)


			end
		end
	end
end