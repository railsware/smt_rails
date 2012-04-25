module SmtRails
  class Engine < ::Rails::Engine
    config.before_configuration do |app|
      app.paths['app/views'] << Rails.root.join("app", "templates") 
    end
    
    initializer "sprockets.smt_rails", :after => "sprockets.environment", :group => :all do |app|
      next unless app.assets
      app.assets.register_engine(".#{SmtRails.template_extension}", Tilt)
      app.config.assets.paths << Rails.root.join("app", "templates")
    end
  end
end