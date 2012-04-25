require 'generators/smt_rails/helpers'
require 'rails'

module SmtRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include SmtRails::Generators::Helpers

      desc "Install into rails"
      
      class_option :manifest, :type => :string, :aliases => "-m", :default => 'application.js',
                                      :desc => "Javascript manifest file to modify (or create)"
                                      
      class_option :template_dir, :type => :string, :aliases => "-t", :default => 'templates',
                                      :desc => "Template dir for mustache templates"

      def inject_mustache
        manifest = options[:manifest]
        template_dir = options[:template_dir]

        create_file("#{js_path}/#{manifest}") unless File.exists?("#{js_path}/#{manifest}")

        append_to_file "#{js_path}/#{manifest}" do
          out = ""
          out << "//= require mustache"
          out << "\n"
          out << "//= require_tree ../../#{template_dir}"
          out << "\n"
          out << "\n"
        end
      end
      
      def create_dir
        template_dir = options[:template_dir]
        empty_directory "#{app_path}/#{template_dir}"
      end

    end
  end
end