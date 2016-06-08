# Rspec::ValidatesTimeliness

*WARN: UNDER DEVELOPMENT*

Simple RSpec matchers for [validates_timeliness](https://github.com/adzap/validates_timeliness)

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
class Person < ActiveRecord::Base
  validates_date :date_of_birth, on_or_before: -> { Date.current }
end
```

And with `rspec-validates_timeliness` we can now make simple assertions about those models:

```ruby
require 'rails_helper'

describe Person, type: :model do
  describe 'validations' do
    it 'validate that date_of_birth on or before Date.current' do
      expect(described_class).to validate_date(:date_of_birth).on_or_before(-> { Date.current })
    end
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog

*Nothing (under development)*
