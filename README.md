# RSpec::ValidatesTimeliness [![Build Status](https://travis-ci.org/yhirano55/rspec-validates_timeliness.svg?branch=master)](https://travis-ci.org/yhirano55/rspec-validates_timeliness)

Simple RSpec matchers for [validates_timeliness](https://github.com/adzap/validates_timeliness)

## Matchers

- **validates_datetime** tests usage of validates_timeliness's `validates_datetime`.
- **validates_date** tests usage of validates_timeliness's `validates_date`.
- **validates_time** tests usage of validates_timeliness's `validate_time`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-validates_timeliness'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-validates_timeliness

## Usage

Here is model:

```ruby
class Person
  include ActiveModel::model

  validates_date :date_of_birth, before: lambda { 18.years.ago }
  validates_time :breakfast_time, is_at: '7:00am'
  validates_time :updated_at, between: ['9:00am', '5:00pm']

  # validates_datetime :start_time, before: :finish_time **[NOT SUPPORT] Method symbol
  # validates_date :created_at, on_or_after: :today      **[NOT SUPPORT] Shorthand
end
```

And with `rspec-validates_timeliness` we can now make simple assertions about those models:

```ruby
require 'spec_helper'

describe Person, type: :model do
  it { is_expected.to validates_date(:date_of_birth).before(lambda { 18.years.ago }) }
  it { is_expected.to validates_date(:date_of_birth).before { 18.years.ago } } # The same as previous example
  it { is_expected.to validates_time(:breakfast_time).is_at('7:00am') }
  it { is_expected.to validates_time(:updated_at).between(['9:00am', '5:00pm']) }
  it { is_expected.to validates_time(:updated_at).on_or_after('9:00am').on_or_before('5:00pm') } # The same as previous example
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog

#### Release 0.1.1 (Jun 13, 2016)

* Fix to optimize expected values.

#### Release 0.1.0 (Jun 12, 2016)
