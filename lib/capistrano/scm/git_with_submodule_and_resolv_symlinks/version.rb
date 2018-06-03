begin
  require 'capistrano/scm/plugin'
rescue LoadError
  module Capistrano
    class Plugin; end
    class SCM
      class Plugin < ::Capistrano::Plugin
      end
    end
  end
end

module Capistrano
  class SCM
    class GitWithSubmoduleAndResolvSymlinks < ::Capistrano::SCM::Plugin
      VERSION = "0.3.1"
    end
  end
end
