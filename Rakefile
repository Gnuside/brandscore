#!/usr/bin/env rake

require 'rake'
require 'rake/testtask'
require 'rspec/core/rake_task'

begin
	require 'bundler/setup'
rescue LoadError
	puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

begin
	require 'rdoc/task'
rescue LoadError
	require 'rdoc/rdoc'
	require 'rake/rdoctask'
	RDoc::Task = Rake::RDocTask
end

#task :default => [:spec]

Rake::TaskManager.record_task_metadata = true

task :default do
	Rake::application.options.show_tasks = :tasks  # this solves sidewaysmilk problem
	Rake::application.options.show_task_pattern = //
	Rake::application.display_tasks_and_comments
end

Rake::RDocTask.new do |rdoc|

#RDoc::Task.new do |rdoc|
	rdoc.title = "Brandscore Tamere"
	rdoc.options << "--all"
	rdoc.options << "--line-numbers"
	rdoc.main = "README.md"
	rdoc.rdoc_dir = "doc"
	rdoc.rdoc_files.include("README.md", "lib/**/*.rb")
end

#Bundler::GemHelper.install_tasks


RSpec::Core::RakeTask.new(:spec) do |t|
	#t.pattern = "test/**/*.rb"
	t.rspec_opts ||= []
	t.rspec_opts << '--color'
	t.fail_on_error = false
end

