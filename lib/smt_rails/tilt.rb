require 'tilt'

module SmtRails
  class Tilt < Tilt::Template
    def self.default_mime_type
      'application/javascript'
    end

    def prepare
      @namespace = "this.#{SmtRails.template_namespace}"
    end

    attr_reader :namespace

    def evaluate(scope, locals, &block)
      <<-MustacheTemplate
  (function() {
  #{namespace} || (#{namespace} = {});
  #{namespace}[#{scope.logical_path.inspect}] = function(object) { return Mustache.render(#{data.inspect}, object) };
  }).call(this);
      MustacheTemplate
    end
  end
end