module SmtRails
  class Engine < ::Rails::Engine
    config.before_configuration do |app|
      app.paths['app/views'] << SmtRails.template_base_path
    end

    initializer "sprockets.smt_rails", :group => :all do |app|
      app.config.assets.configure do |env|
        env.register_engine(".#{SmtRails.template_extension}", Tilt)
      end
      app.config.assets.paths << SmtRails.template_base_path
    end
  end
end
