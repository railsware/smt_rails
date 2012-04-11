module SmtRails
  module Generators
    module Helpers

      def asset_path
        "app/assets"
      end

      def js_path
        "#{asset_path}/javascripts"
      end

      def views_path
        "app/views"
      end

    end
  end
end