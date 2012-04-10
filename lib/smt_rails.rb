require "smt_rails/version"
require "smt_rails/config"

module SmtRails
  extend Config

  autoload(:Tilt, 'smt_rails/tilt')

  if defined?(Rails)
    require 'smt_rails/engine'
  else
    require 'sprockets'
    Sprockets.register_engine ".#{SmtRails.template_extension}", Tilt
  end
end

# init action view handler
require "smt_rails/mustache"