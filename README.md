# Data::Criteria

is a set of conditions, is a matcher for a hash or an object. Data::Criteria is useful for filtering a collection(e.g. array of hases) by complex conditions.

**Example**

```ruby
require 'data-criteria'

# You have users collection, then want to filter them.
users = [
  {
    id: 1,
    name: "Takeshi",
    city: 'Kagawa',
    age: 33,
    money: 100_000,
  },
  {
    id: 2,
    name: "Ryota",
    city: 'Hiroshima',
    age: 18,
    money: 500,
  },
  {
    id: 3,
    name: "Masanori",
    city: 'Hokkaido',
    age: 14,
    money: 30,
  },
]

# filter by name.
criteria = Data::Criteria.new(name: 'Takeshi')
users.select {|user| criteria.match_all?(user) }
# => [
#   {
#     id: 1,
#     name: "Takeshi",
#     city: 'Kagawa',
#     age: 33,
#     money: 100_000,
#   }
# ]

# filter by name AND city AND age AND money.
criteria = Data::Criteria.new(
  name: /ta/i,
  city: %w(Kagawa Hiroshima),
  age: 0..20,
  money: '>= 300',
)
users.select {|user| criteria.match_all?(user) }
# => [
#   {
#     id: 2,
#     name: "Ryota",
#     city: 'Hiroshima',
#     age: 18,
#     money: 500,
#   }
# ]

# filter by age with custom matcher.
criteria = Data::Criteria.new(
  age: proc {|actual| actual % 7 == 0 },
)
users.select {|user| criteria.match_all?(user) }
# => [
#   {
#     id: 3,
#     name: "Masanori",
#     city: 'Hokkaido',
#     age: 14,
#     money: 30,
#   },
# ]
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'data-criteria'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install data-criteria


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/data-criteria.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

