require 'bundler/gem_tasks'

#############################################################################
#
# Helper functions
#
#############################################################################

def name
  @name ||= Dir['*.gemspec'].first.split('.').first
end

def version
  line = File.read("lib/#{name}/version.rb")[/^\s*VERSION\s*=\s*.*/]
  line.match(/.*VERSION\s*=\s*['"](.*)['"]/)[1]
end

#############################################################################
#
# Standard tasks
#
#############################################################################

task :default => :spec

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ['--color']
  t.pattern = 'spec/*_spec.rb'
end

require 'rdoc/task'
RDoc::Task.new do |t|
  t.rdoc_dir = 'rdoc'
  t.title = "#{name} #{version}"
  t.rdoc_files.include('README*')
  t.rdoc_files.include('lib/**/*.rb')
  t.markup = 'tomdoc'
end

desc 'Open an irb session preloaded with this library'
task :console do
  sh "irb -rubygems -r ./lib/#{name}.rb"
end
