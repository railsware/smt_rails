require "mustache"
require "active_support"

# Monkey patch mustache to render {{>partial}}
class Mustache
  def self.partial(name)
    File.read("#{template_path}/#{File.dirname(name.to_s)}/_#{File.basename(name.to_s)}.#{template_extension}")
  end
end

module SmtRails
  module Mustache
    def self.call(template)
      if template.locals.include?(SmtRails.action_view_key.to_s) || template.locals.include?(SmtRails.action_view_key.to_sym)
        ::Mustache.template_path = SmtRails.template_base_path
        "Mustache.render(#{ERB.new(template.source).result.inspect}, #{SmtRails.action_view_key.to_s}).html_safe"
      else
        "#{template.source.inspect}.html_safe"
      end
    end
  end
end

ActiveSupport.on_load(:action_view) do
  ActionView::Template.register_template_handler(::SmtRails.template_extension.to_sym, ::SmtRails::Mustache)
end
