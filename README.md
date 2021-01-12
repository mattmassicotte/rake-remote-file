# rake-remote-file

This is a simple gem that adds capabilities to rake to emulate the `file` task, but for files that reside on a remote server. Currently.
S3 is supported.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rake-remote-file'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rake-remote-file

## Usage

This DSL extension creates two tasks. First, a `file "/path/to/local/file"`, and then a remote task named `https://s3.amazonaws.com/#{bucket}/#{key}`
which behaves functionally like a `file` task.

    remote_file '/path/to/local/file', 'https://s3.amazonaws.com/#{bucket}/#{key}'

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rake-remote-file. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/mattmassicotte/rake-remote-file/blob/master/CODE_OF_CONDUCT.md).


## Code of Conduct

Everyone interacting in the rake-remote-file project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mattmassicotte/rake-remote-file/blob/master/CODE_OF_CONDUCT.md).
