# Capistrano::Stretcher::Rails

rails specific tasks for capistrano-stretcher.

this gem insert bundler and assets precompile tasks to your build task for stretcher assets.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-stretcher-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-stretcher-rails

## Usage

You need to add `require "capistrano/stretcher/rails"` under `require "capistrano/stretcher"` in your Capfile

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pepabo/capistrano-stretcher-rails.

## LICENSE

The MIT License (MIT)

Copyright (c) 2015- GMO Pepabo, Inc.
