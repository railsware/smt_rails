# SmtRails

Shared mustache templates for rails 3.

## Installation

Add this line to your application's Gemfile:

    gem 'smt_rails', :git => 'git://github.com/railsware/smt_rails.git'

And then execute:

    $ bundle
    
Or install it yourself as:
	
    $ gem install smt_rails

## Usage

    $ rails g smt_rails:install
    
Generator add into "application.js" requirements for mustache and "templates" folder in "app/views". Next you can create mustache templates in this folder or subfolders.

For example:

File: "app/views/templates/_test.mustache"

    Hello {{msg}}!!!
    
In view you can render this template by this way:

    <%= render "templates/test", :mustache => {msg: "Test"} %> 
    
The same template you can render in JavaScript:

    var content = SMT['templates/test']({msg: "Test"});

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
