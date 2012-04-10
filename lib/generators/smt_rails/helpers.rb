module SmtRails
  module Generators
    module Helpers

      def asset_path
        "app/assets"
      end

      def js_path
        "#{asset_path}/javascripts"
      end

      def template_path
        "app/views/templates"
      end

    end
  end
end