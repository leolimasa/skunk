require "rake/testtask"

desc "Runs all unit tests"
Rake::TestTask.new do |t|
	t.libs = ["src/main", "src/test"]
	t.test_files = FileList['src/test/skunk/core/tc_*.rb']
	t.verbose = true
end

task :default => :test