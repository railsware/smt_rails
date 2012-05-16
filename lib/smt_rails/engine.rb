module SmtRails
  class Engine < ::Rails::Engine
    config.before_configuration do |app|
      app.paths['app/views'] << SmtRails.template_base_path
    end
    
    initializer "sprockets.smt_rails", :after => "sprockets.environment", :group => :all do |app|
      next unless app.assets
      app.assets.register_engine(".#{SmtRails.template_extension}", Tilt)
      app.config.assets.paths << SmtRails.template_base_path
    end
  end
end