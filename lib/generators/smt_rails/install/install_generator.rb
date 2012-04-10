require 'generators/smt_rails/helpers'
require 'rails'

module SmtRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include SmtRails::Generators::Helpers

      desc "Generates manifest"
      
      class_option :manifest, :type => :string, :aliases => "-m", :default => 'application.js',
                                      :desc => "Javascript manifest file to modify (or create)"

      def inject_mustache
        manifest = options[:manifest]

        create_file("#{js_path}/#{manifest}") unless File.exists?("#{js_path}/#{manifest}")

        append_to_file "#{js_path}/#{manifest}" do
          out = ""
          out << "//= require mustache"
          out << "\n"
          out << "//= require_tree ../../views/templates"
          out << "\n"
          out << "\n"
        end
      end
      
      def create_dir
        empty_directory "#{template_path}"
      end

    end
  end
end