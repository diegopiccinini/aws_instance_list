# AwsInstanceList

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/aws_instance_list`. To experiment with that code, run `bin/console` for an interactive prompt.

This gem is an easy way to get AWS instance list in all regions.
The class AwsIntanceList::List runs one Thread by region to get the data in each one. Finally join all in one Array.

Using the AWS describe instance we can get the instances but the metrics are not available.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aws_instance_list'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aws_instance_list

## Usage

As a library you need require it after install the gem.

```ruby

require 'aws_instance_list'

list= AwsInstanceList::List.new

# sample to get all rds instances

list.db_list # will return an array like this

# db_instance_identifier, engine, storage (GBytes), status, free storage available, region

#\>
[
["db1", "mysql", 50, "available", 45.3829460144043, "eu-west-1"],
["db2", "mysql", 50, "available", 44.111881256103516, "eu-west-1"],
["db3", "mysql", 20, "available", 15.590309143066406, "eu-west-2"],
["db4", "mysql", 100, "available", 94.48283767700195, "eu-west-2"]
]

```



## Test
Add a test.env file with:

```bash
DB_INSTANCE_IDENTIFIER=identifier_name_db
REGION=aws_region_to_test # sample: eu-central-1
LONG_REGION=aws_region_with_pagination_to_test # sample: eu-west-1

```

And run

```bash
rspec
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/aws_instance_list. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AwsInstanceList project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/aws_instance_list/blob/master/CODE_OF_CONDUCT.md).
