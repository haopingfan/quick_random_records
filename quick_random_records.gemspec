# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "quick_random_records/version"

Gem::Specification.new do |spec|
  spec.name          = "quick_random_records"
  spec.version       = QuickRandomRecords::VERSION
  spec.authors       = ["derekfan"]
  spec.email         = ["haoping.fan@gmail.com"]

  spec.summary       = %q{Returns random records for Ruby Models fast}
  spec.description   = %q{Returns random records for Ruby Models fast and quick}
  spec.homepage      = "https://github.com/haopingfan/quick_random_records"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "activerecord", ">= 3"
end
