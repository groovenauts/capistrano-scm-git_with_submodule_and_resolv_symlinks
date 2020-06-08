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
  spec.homepage      = "https://github.com/groovenauts/capistrano-scm-git_with_submodule_and_resolv_symlinks"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", ">= 3.7.0", "< 3.12.0"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "mocha", "~> 1.2"
end
