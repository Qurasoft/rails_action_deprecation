lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_action_deprecation/version"

Gem::Specification.new do |spec|
  spec.name = "rails_action_deprecation"
  spec.version = RailsActionDeprecation::VERSION
  spec.authors = ["Lucas Keune"]
  spec.email = ["lucas.keune@qurasoft.de"]

  spec.summary = %q{Mark resources and endpoints as deprecated}
  spec.description = %q{Mark specific routes or actions in your Rails project as deprecated or sunset. You can specify the date of deprecation or sunset and provide additional resources as links to your users.}
  spec.homepage = "https://github.com/Qurasoft/rails_action_deprecation"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise "RubyGems 2.0 or newer is required to protect against public gem pushes." unless spec.respond_to?(:metadata)

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Qurasoft/rails_action_deprecation"
  spec.metadata["changelog_uri"] = "https://github.com/Qurasoft/rails_action_deprecation/blob/main/CHANGES.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 4.2"

  spec.add_development_dependency "bundler", ">= 1.17"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "rspec", ">= 3.0"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "simplecov"
end
