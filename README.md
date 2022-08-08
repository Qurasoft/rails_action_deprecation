# Rails Action Deprecation

[![Gem Version](https://badge.fury.io/rb/rails_action_deprecation.svg)](https://badge.fury.io/rb/rails_action_deprecation)
![RSpec](https://github.com/qurasoft/rails_action_deprecation/actions/workflows/ruby.yml/badge.svg)

Deliver the Deprecation and Sunset HTTP header for your old and trashy endpoints.

When phasing out obsolete or out of date endpoints it is necessary to notify your users.
An easy way, in addition to your other communication channels, is to directly mark the responses of your endpoints as deprecated.

This is achieved by the two functions provided by this gem.
The (draft) Deprecation HTTP header is to mark an endpoint as deprecated and signal that it will be shut down in the future.
The Sunset HTTP header is used to mark an endpoint for deletion.
It signifies that the endpoint may be removed without warning after the specified date.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_action_deprecation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_action_deprecation

## Usage

To enable deprecation and sunset in your controller, simply use the provided `deprecate_endpoint` and `sunset_endpoint` functions.
These register an `after_action` hook that sets the relevant HTTP headers and outputs a message via `ActiveSupport::Deprecation`.

Both functions take exactly the same parameters.
The first is a DateTime describing the date of deprecation or sunset.
By default the deprecation or sunset is set for any action in the controller.
To limit this the `only:` parameter can be used exactly as it is available for the rails controller hooks.

If you want to make more information available to your users, the `link:` parameter must be specified with a percent encoded URL.
This URL will be part of the response's Link HTTP header with the relation `deprecation` or respectively `sunset`.

Example with deprecated and/or sunset `create` and `destroy` actions:
```ruby
class ExampleController < ActionController::Base
  deprecate_endpoint DateTime.new(2022, 07, 01, 12, 34, 56), only: [:create]
  deprecate_endpoint DateTime.new(2022, 07, 01, 12, 34, 56), only: [:destroy], link: "https://github.com/Qurasoft"
  sunset_endpoint DateTime.new(2023, 07, 01), only: [:destroy]

  def index
    render json: ['element1', 'element2']
  end

  def show
    render json: 'element1'
  end

  def create
    render json: 'newElement'
  end

  def update
    render json: 'changedElement'
  end

  def destroy
    head :no_content
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/qurasoft/rails_action_deprecation.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
