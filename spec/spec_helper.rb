$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec'
require 'mocha/api'
require 'capistrano/scm/git_with_submodule_and_resolv_symlinks'

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  config.mock_framework = :mocha
  config.order = "random"
end

