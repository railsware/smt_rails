module SmtRails
  class Engine < ::Rails::Engine
    config.before_configuration do |app|
      app.paths['app/views'] << SmtRails.template_base_path
    end

    initializer "sprockets.smt_rails", :group => :all do |app|
      app.config.assets.configure do |env|
        if env.respond_to?(:register_transformer)
          env.register_mime_type 'text/html', extensions: ['.mustache'], charset: :html
          env.register_preprocessor 'text/html', Tilt
        else
          env.register_engine(".#{SmtRails.template_extension}", Tilt)
        end
      end
      app.config.assets.paths << SmtRails.template_base_path
    end
  end
end
