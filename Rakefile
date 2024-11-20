# frozen_string_literal: true

require "bundler/gem_tasks"
require 'rake/testtask'
require "rubocop/rake_task"

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
end

task :default => :test

RuboCop::RakeTask.new

desc "Import the SVG icons for gem packaging"
task :icon_import do
  node_npm_error = "Node/NPM required for importing SVG icons"
  abort node_npm_error unless exec?("node -v") && exec?("npm -v")

  sh 'npm install'
  sh './bin/import'
end
Rake::Task["build"].enhance ["icon_import"]

desc "Load CSS Test through webserver"
task :test_css do
  require "rack/builder"
  require "rack/static"
  require "rackup/server"
  require "launchy"

  app = Rack::Builder.new do
    use Rack::Static, urls: ['/images'], root: "#{__dir__}/vendor/assets"
    use Rack::Static, urls: ['/stylesheets'], root: "#{__dir__}/lib/assets"
    use Rack::Static, urls: { '/' => 'css.html' }, root: 'test'

    run -> { [404, { 'Content-Type' => 'text/plain' }, ['404 - Not Found']] }
  end

  Thread.new { sleep(1) && Launchy.open("http://localhost:3000") }
  Rackup::Server.start app:, Silent: true, Port: 3000
end

def exec?(cmd) = !!system("#{cmd} > /dev/null 2>&1")
