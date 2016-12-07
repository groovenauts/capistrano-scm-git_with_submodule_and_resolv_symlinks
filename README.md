# capistrano-scm-git_with_submodule_and_resolv_symlinks

[![Gem Version](https://badge.fury.io/rb/capistrano-scm-git_with_submodule_and_resolv_symlinks.png)](https://rubygems.org/gems/capistrano-scm-git_with_submodule_and_resolv_symlinks) [![Build Status](https://secure.travis-ci.org/groovenauts/capistrano-scm-git_with_submodule_and_resolv_symlinks.png)](https://travis-ci.org/groovenauts/capistrano-scm-git_with_submodule_and_resolv_symlinks)

This is Capistrano [Custom SCM plugin](http://capistranorb.com/documentation/advanced-features/custom-scm/), which supports:

- Git with submodule
- Resolving symlinks
- Subtree

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-scm-git_with_submodule_and_resolv_symlinks', require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-scm-git_with_submodule_and_resolv_symlinks

## Usage

Add these lines to your Capfile:

```ruby
require "capistrano/scm/git_with_submodule_and_resolv_symlinks"
install_plugin Capistrano::SCM::GitWithSubmoduleAndResolvSymlinks
```

## Incompatibilties with Capistrano::SCM::Git

### `repo_path` is non-bare repository

Capistrano::SCM::Git creates `repo_path` as bare repository (by `git clone --mirror url repo_path`),
but Capistrano::SCM::GitWithSubmoduleAndResolvSymlinks creates `repo_path` as non-bare repository
(by `git clone url repo_path`).

If you want to switch SCM, delete `repo_path` before deploy.

### `current_revision` is abbreviated

With Capistrano::SCM::Git, `current_version` is non-abbreviated commit hash (like `81cec13b777ff46348693d327fc8e7832f79bf43`),
but with Capistrano::SCM::GitWithSubmoduleAndResolvSymlinks, `current_version` is abbreviated (like `81cec13`).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/groovenauts/capistrano-scm-git_with_submodule_and_resolv_symlinks.

