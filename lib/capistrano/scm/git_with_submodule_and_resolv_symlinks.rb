require 'capistrano/scm/plugin'
require 'capistrano/scm/git_with_submodule_and_resolv_symlinks/version'
require 'cgi'
require 'shellwords'
require 'uri'

module Capistrano
  class SCM
    class GitWithSubmoduleAndResolvSymlinks < ::Capistrano::SCM::Plugin
      def nsp
        "git_with_submodule_and_resolv_symlinks"
      end

      def set_defaults
        set_if_empty :"#{nsp}_wrapper_path", lambda {
          # Try to avoid permissions issues when multiple users deploy the same app
          # by using different file names in the same dir for each deployer and stage.
          suffix = [:application, :stage, :local_user].map { |key| fetch(key).to_s }.join("-")
          "#{fetch(:tmp_dir)}/git-ssh-#{suffix}.sh"
        }
        set_if_empty :"#{nsp}_environmental_variables", lambda {
          {
            git_askpass: "/bin/echo",
            git_ssh: fetch(:"#{nsp}_wrapper_path")
          }
        }
      end

      def register_hooks
        nsp = "git_with_submodule_and_resolv_symlinks"
        after "deploy:new_release_path", "#{nsp}:create_release"
        before "deploy:check", "#{nsp}:check"
        before "deploy:set_current_revision", "#{nsp}:set_current_revision"
      end

      def define_tasks
        eval_rakefile File.expand_path("../tasks/git_with_submodule_and_resolv_symlinks.rake", __FILE__)
      end

      def repo_mirror_exists?
        backend.test " [ -d #{repo_path}/.git ] "
      end

      def check_repo_is_reachable
        git :'ls-remote', git_repo_url, "HEAD"
      end

      def clone_repo
        git :clone, git_repo_url, repo_path.to_s
      end

      def update_mirror
        git :remote, "set-url", "origin", git_repo_url
        git :remote, :update, "--prune"
        git :checkout, "--detach", real_branch
        git :submodule, :update, "--init"
      end

      def release
        if fetch(:repo_tree)
          backend.execute "rsync -ar --copy-links --exclude=.git\* #{repo_path}/#{fetch(:repo_tree)}/ #{release_path}"
        else
          backend.execute "rsync -ar --copy-links --exclude=.git\* #{repo_path}/ #{release_path}"
        end
      end

      def fetch_revision
        backend.capture(:git, "rev-list", "--max-count=1", real_branch)
      end

      def real_branch
        @real_branch ||= if backend.test(:git, :"rev-parse", "origin/#{fetch(:branch)}")
                           "origin/#{fetch(:branch)}"
                         else
                           fetch(:branch)
                         end
      end

      def git(*args)
        args.unshift :git
        backend.execute(*args)
      end

      def git_repo_url
        if fetch(:git_http_username) && fetch(:git_http_password)
          URI.parse(repo_url).tap do |repo_uri|
            repo_uri.user     = fetch(:git_http_username)
            repo_uri.password = CGI.escape(fetch(:git_http_password))
          end.to_s
        elsif fetch(:git_http_username)
          URI.parse(repo_url).tap do |repo_uri|
            repo_uri.user = fetch(:git_http_username)
          end.to_s
        else
          repo_url
        end
      end
    end
  end
end
