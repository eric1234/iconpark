# frozen_string_literal: true

require_relative "lib/iconpark/version"

Gem::Specification.new do |spec|
  spec.name = "iconpark"
  spec.version = Iconpark::VERSION

  spec.authors = ["Eric Anderson"]
  spec.email = ["afflicted.nimbly928@anonaddy.me"]

  spec.summary = "Integrates Iconpark with the Rails asset pipelines"
  spec.files = Dir['lib/**/*.rb'] + Dir['lib/**/*.css'] + Dir['vendor/**/*.svg']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rack"
  spec.add_development_dependency "rackup"
  spec.add_development_dependency "launchy"
end
