# SmtRails

Shared mustache templates for rails 3.

## Installation

Add this line to your application's Gemfile:

    gem 'smt_rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smt_rails

## Usage

## Configuration

    SmtRails.configure do |config|
      config.template_extension = 'mustache' # change extension of mustache templates
      config.action_view_key    = 'mustache' # change name of key for rendering in ActionView mustache template
      config.template_namespace = 'SMT'      # change templates namespace in javascript
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
