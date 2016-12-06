require 'spec_helper'

module Capistrano
  describe SCM::GitWithSubmoduleAndResolvSymlinks do
    subject { Capistrano::SCM::GitWithSubmoduleAndResolvSymlinks.new }

    # This allows us to easily use `set`, `fetch`, etc. in the examples.
    let(:env){ Capistrano::Configuration.env }

    # Stub the SSHKit backend so we can set up expectations without the plugin
    # actually executing any commands.
    let(:backend) { stub }
    before { SSHKit::Backend.stubs(:current).returns(backend) }

    # Mimic the deploy flow tasks so that the plugin can register its hooks.
    before do
      Rake::Task.define_task("deploy:new_release_path")
      Rake::Task.define_task("deploy:check")
      Rake::Task.define_task("deploy:set_current_revision")
    end

    # Clean up any tasks or variables that the plugin defined.
    after do
      Rake::Task.clear
      Capistrano::Configuration.reset!
    end

    describe "#git" do
      it "should call git in the context, with arguments" do
        backend.expects(:execute).with(:git, :init)
        subject.git(:init)
      end
    end
  end
end
