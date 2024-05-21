require_relative 'lib/super_date_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "super_date_parser"
  spec.version       = SuperDateParser::VERSION
  spec.authors       = ["Greg Cesnik"]
  spec.email         = ["greg@twinsunsolutions.com"]

  spec.summary       = 'Converts date range strings to usable date strings or date times'
  spec.description   = 'Converts date range strings to usable date strings or date times'
  spec.homepage      = "https://github.com/gcesnik2/super_date_parser"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gcesnik2/super_date_parser"
  spec.metadata["changelog_uri"] = "https://github.com/gcesnik2/super_date_parser/"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
end
