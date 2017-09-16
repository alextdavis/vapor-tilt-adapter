# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "vapor_tilt_adapter/version"

Gem::Specification.new do |spec|
  spec.name          = "vapor_tilt_adapter"
  spec.version       = VaporTiltAdapter::VERSION
  spec.authors       = ["Alex T. Davis"]
  spec.email         = ["git@alextdavis.me"]

  spec.summary       = "This is the Ruby half of 'tilt-provider', a tool for using template "\
                       "engines supported by Tilt with the Vapor web framework for Swift. "
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "http://github.com/alextdavis/vapor-tilt-adapter"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "tilt", "~>2.0"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
