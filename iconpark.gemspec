require_relative "lib/iconpark/version"

Gem::Specification.new do |spec|
  spec.name = "iconpark"
  spec.version = Iconpark::VERSION

  spec.authors = ["Eric Anderson"]
  spec.email = ["afflicted.nimbly928@anonaddy.me"]
  spec.metadata = { "source_code_uri" => "https://github.com/eric1234/iconpark" }

  spec.summary = "Integrates Iconpark with the Rails asset pipelines"
  spec.files = Dir['lib/**/*.rb'] + Dir['lib/**/*.css'] + Dir['vendor/**/*.svg']
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"

  %w[
    debug minitest nokogiri rubocop rubocop-rake rubocop-minitest
    rack rackup launchy rdoc
  ].each do |dev_dep|
    spec.add_development_dependency dev_dep
  end
end
