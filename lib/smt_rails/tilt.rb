require 'tilt'
require 'execjs'
require 'pathname'

module SmtRails
  class MustacheCompile
    class << self
      def compile(source, options = {})
        context.eval("Mustache.compile(#{source.inspect})")
      end

      def compilePartial(name, source, options = {})
        context.eval("Mustache.compilePartial(#{name.inspect}, #{source.inspect})")
      end

      private

      def context
        @context ||= ExecJS.compile(source)
      end

      def source
        @source ||= path.read
      end

      def path
        @path ||= assets_path.join('javascripts', 'mustache.js')
      end

      def assets_path
        @assets_path ||= Pathname(__FILE__).dirname.join('..', '..', 'vendor', 'assets')
      end
    end
  end

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
  #{namespace}Cache || (#{namespace}Cache = {});
  #{namespace}Cache[#{template_key.inspect}] = Mustache.compile(#{data.inspect});
  Mustache.compilePartial(#{template_key.inspect}, #{data.inspect});

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
