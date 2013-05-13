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

    def precompile(template_key, template)
      @context ||= begin
        mustache_path = File.expand_path("../../../vendor/assets/javascripts/mustache.js", __FILE__)
        ExecJS.compile File.read(mustache_path)
      end
      [@context.call("Mustache.compile", template), @context.call("Mustache.compilePartial", template_key, template)]
    end

    def evaluate(scope, locals, &block)
      template_key = path_to_key scope
      template_function, partial_function = precompile(template_key, data)
      <<-MustacheTemplate
  (function() {
  #{namespace} || (#{namespace} = {});
  #{namespace}Cache || (#{namespace}Cache = {});
  #{namespace}Cache[#{template_key.inspect}] = #{template_function};
  #{partial_function};

  #{namespace}[#{template_key.inspect}] = function(object) {
    if (!object){ object = {}; }
    return #{SmtRails.template_namespace}Cache[#{template_key.inspect}](object);
  };
  }).call(this);
      MustacheTemplate
    end

    def path_to_key(scope)
      path = scope.logical_path.to_s.split('/')
      path.last.gsub!(/^_/, '')
      path.join('/')
    end
  end
end
