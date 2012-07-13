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
      template_key = path_to_key scope
      <<-MustacheTemplate
  (function() { 
  #{namespace} || (#{namespace} = {});
  #{namespace}[#{template_key.inspect}] = function(object) {
    var template = #{data.inspect};
    if (object == null){
      return template;
    } else {
      var partials = {};
      for (var key in #{SmtRails.template_namespace}) {
        partials[key] = #{SmtRails.template_namespace}[key]();
      }
      return Mustache.render(template, object, partials);
    }
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
