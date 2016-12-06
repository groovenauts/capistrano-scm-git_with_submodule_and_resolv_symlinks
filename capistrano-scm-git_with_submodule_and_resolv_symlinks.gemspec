# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/scm/git_with_submodule_and_resolv_symlinks/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-scm-git_with_submodule_and_resolv_symlinks"
  spec.version       = Capistrano::SCM::GitWithSubmoduleAndResolvSymlinks::VERSION
  spec.authors       = ["YAMADA Tsuyoshi"]
  spec.email         = ["tsu-yamada@groovenauts.jp"]

  spec.summary       = %q{Capistrano Git SCM Plugin with submodule and resolving symlink}
  spec.description   = %q{Capistrano Git SCM Plugin with submodule and resolving symlink}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", "~> 3.7.0.beta1"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "mocha", "~> 1.2"
end
