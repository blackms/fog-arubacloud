require 'bundler/gem_tasks'

require 'rubygems'
require 'bundler/setup'
require 'rake/testtask'

require File.dirname(__FILE__) + '/lib/fog/arubacloud'

task :default => :test

def name
  @name ||= Dir['*.gemspec'].first.split('.').first
end

GEM_NAME = "#{name}"

def version
  Fog::ArubaCloud::VERSION
end

def gem_file
  "#{name}-#{version}.gem"
end

def gemspec_file
  "#{name}.gemspec"
end

def replace_header(head, header_name)
  head.sub!(/(\.#{header_name}\s*= ').*'/) { "#{$1}#{send(header_name)}'"}
end

Rake::TestTask.new do |t|
  t.pattern = File.join('spec', '**', '*_spec.rb')
  t.libs << 'spec'
  t.verbose = true
end

namespace :test do
  mock = 'true' || ENV['FOG_MOCK']
  task :travis do
    ENV['COVERAGE'] = 'false' if RUBY_PLATFORM == 'java'
    sh("export FOG_MOCK=#{mock} && bundle exec shindont")
  end
end

task :release => ["release:prepare", "release:publish"]

namespace :release do
  task :preflight do
    unless `git branch` =~ /^\* master$/
      puts "You must be on the master branch to release!"
      exit!
    end
    if `git tag` =~ /^\* v#{version}$/
      puts "Tag v#{version} already exists!"
      exit!
    end
  end

  task :prepare => :preflight do
    Rake::Task[:build].invoke
    sh "gem install pkg/#{name}-#{version}.gem"
    Rake::Task[:git_mark_release].invoke
  end

  task :publish do
    Rake::Task[:git_push_release].invoke
    Rake::Task[:gem_push].invoke
  end
end

task :git_mark_release do
  sh "git commit --allow-empty -a -m 'Release #{version}'"
  sh "git tag v#{version}"
end

task :git_push_release do
  sh "git push origin master"
  sh "git push origin v#{version}"
end

task :gem_push do
  sh "gem push pkg/#{name}-#{version}.gem"
end

desc "Build fog-#{version}.gem"
task :build => :gemspec do
  sh 'mkdir -p pkg'
  sh "gem build #{gemspec_file}"
  sh "mv #{gem_file} pkg"
end
task :gem => :build

desc "Updates the gemspec and runs 'validate'"
task :gemspec => :validate do
  spec = File.read(gemspec_file)

  replace_header(spec, :name)
  replace_header(spec, :version)
  replace_header(spec, :date)

  File.open(gemspec_file, 'w') { |io| io.write(spec) }
  puts "Updated #{gemspec_file}"
end

desc 'Run before pushing out the code'
task :validate do
  libfiles = Dir['lib/*'] - %W(lib/#{name}.rb lib/#{name} lib/tasks)
  unless libfiles.empty?
    puts "Directory `lib` should only contain a `#{name}.rb` file and `#{name}` dir."
    #exit!
  end
  unless Dir['VERSION*'].empty?
    puts 'A `VERSION` file at root level violates Gem best practices.'
    exit!
  end
end