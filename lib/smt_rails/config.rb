module SmtRails
  # Change config options in an initializer:
  #
  # SmtRails.template_extension = 'mustache'
  #
  # Or in a block:
  #
  # SmtRails.configure do |config|
  #   config.template_extension = 'mustache'
  # end

  module Config
    attr_accessor :template_base_path, :template_extension, :action_view_key, :template_namespace

    def configure
      yield self
    end
    
    def template_base_path
      @template_base_path ||= Rails.root.join("app", "templates")
    end

    def template_extension
      @template_extension ||= 'mustache'
    end
    
    def action_view_key
      @action_view_key ||= 'mustache'
    end
    
    def template_namespace
      @template_namespace ||= 'SMT'
    end
  end
end
