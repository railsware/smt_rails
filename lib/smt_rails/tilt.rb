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
  #{namespace}Partials || (#{namespace}Partials = {});
  
  #{namespace}[#{template_key.inspect}] = function(object) {
    var template = #{data.inspect};
    if (object == null){
      return template;
    } else {
      return Mustache.render(template, object, #{SmtRails.template_namespace}Partials);
    }
  };
  
  #{namespace}Partials[#{template_key.inspect}] = #{namespace}[#{template_key.inspect}]();
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
