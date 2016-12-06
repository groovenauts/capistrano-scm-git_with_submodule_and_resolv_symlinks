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

And add these lines to your Capfile:

```ruby
require "capistrano/scm/git_with_submodule_and_resolv_symlinks"
install_plugin Capistrano::SCM::GitWithSubmoduleAndResolvSymlinks
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/groovenauts/capistrano-scm-git_with_submodule_and_resolv_symlinks.

