module SmtRails
  class Engine < ::Rails::Engine
    initializer "sprockets.smt_rails", :after => "sprockets.environment", :group => :all do |app|
      next unless app.assets
      app.assets.register_engine(".#{SmtRails.template_extension}", Tilt)
      app.config.assets.paths << Rails.root.join("app", "views")
    end
  end
end