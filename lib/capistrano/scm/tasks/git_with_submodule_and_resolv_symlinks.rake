# This trick lets us access the GitWithSubmoduleAndResolvSymlinks plugin within `on` blocks.
scm = self

namespace scm.nsp do
  desc "Upload the git wrapper script, this script guarantees that we can script git without getting an interactive prompt"
  task :wrapper do
    on release_roles :all do
      execute :mkdir, "-p", File.dirname(fetch(:"#{scm.nsp}_wrapper_path")).shellescape
      upload! StringIO.new("#!/bin/sh -e\nexec /usr/bin/ssh -o PasswordAuthentication=no -o StrictHostKeyChecking=no \"$@\"\n"), fetch(:"#{scm.nsp}_wrapper_path")
      execute :chmod, "700", fetch(:"#{scm.nsp}_wrapper_path").shellescape
    end
  end

  desc "Check that the repository is reachable"
  task check: :"#{scm.nsp}:wrapper" do
    fetch(:branch)
    on release_roles :all do
      with fetch(:"#{scm.nsp}_environmental_variables") do
        scm.check_repo_is_reachable
      end
    end
  end

  desc "Clone the repo to the cache"
  task clone: :"#{scm.nsp}:wrapper" do
    on release_roles :all do
      if scm.repo_mirror_exists?
        info t(:mirror_exists, at: repo_path)
      else
        within deploy_path do
          with fetch(:"#{scm.nsp}_environmental_variables") do
            scm.clone_repo
          end
        end
      end
    end
  end

  desc "Update the repo mirror to reflect the origin state"
  task update: :"#{scm.nsp}:clone" do
    on release_roles :all do
      within repo_path do
        with fetch(:"#{scm.nsp}_environmental_variables") do
          scm.update_mirror
        end
      end
    end
  end

  desc "Copy repo to releases"
  task create_release: :"#{scm.nsp}:update" do
    on release_roles :all do
      with fetch(:"#{scm.nsp}_environmental_variables") do
        within repo_path do
          execute :mkdir, "-p", release_path
          scm.release
        end
      end
    end
  end

  desc "Determine the revision that will be deployed"
  task :set_current_revision do
    on release_roles :all do
      within repo_path do
        with fetch(:"#{scm.nsp}_environmental_variables") do
          set :current_revision, scm.fetch_revision
        end
      end
    end
  end
end
