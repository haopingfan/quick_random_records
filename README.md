## QuickRandomRecords

`quick_random_records` is a Ruby Gem that empowers ActiveRecord Models with the ability to return random records dramatically fast.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quick_random_records'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quick_random_records

## Usage

```ruby
# return ActiveRecord::Relation contains 10 random model objects from User Table

users = User.random_records(10)
```

## Dramatically fast, compared to other random records strategies

Scenario: query 100 random records from table with 550,000 data rows.

1. `quick_random_records` costs `25.0ms`.
![alt text](https://user-images.githubusercontent.com/19776127/40585122-b6a90cae-61df-11e8-8b54-96f238a370f2.png)
2. `Model.order("RAND()").limit(num)` costs `3314.1ms`.
![alt text](https://user-images.githubusercontent.com/19776127/40585124-b6f7b0a2-61df-11e8-9884-86f96354efbc.png)
3. `Model.where(id: Model.pluck(:id).sample(num))` costs `1659.4ms`.
![alt text](https://user-images.githubusercontent.com/19776127/40585123-b6d07f00-61df-11e8-9622-e4cd61100e37.png)


![alt text](https://user-images.githubusercontent.com/19776127/40585160-59fe14bc-61e0-11e8-891f-ecd144d46905.png)

![alt text](https://user-images.githubusercontent.com/19776127/40585161-5add98b2-61e0-11e8-9265-11bef7a1536d.png)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/quick_random_records. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
