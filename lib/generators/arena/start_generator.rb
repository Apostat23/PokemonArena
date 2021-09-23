module Arena
  module Generators
    class StartGenerator < Rails::Generators::Base
      # Source root of the gem files
      source_root File.expand_path("../../../..",__FILE__)
      def Start
        generate "controller", "start index pokemon _top _bottom _menu", "--skip-template-engine", "--no-stylesheets"
        generate "scaffold", "pokemon abilities:text base_experience:integer forms:string game_indices:text height:integer held_items:text api_id:integer is_default:boolean location_area_encounters:string moves:text name:string order:integer past_types:text species:string sprites:text stats:text types:text weight:integer", "--skip-template-engine", "--no-stylesheets"
        directory "app/assets/fonts", "app/assets/fonts"
        directory "app/assets/images", "app/assets/images"
        copy_file "app/assets/stylesheets/start.scss", "app/assets/stylesheets/start.scss", force: true
        directory "app/controllers/api", "app/controllers/api"
        copy_file "app/controllers/application_controller.rb", "app/controllers/application_controller.rb", force: true
        copy_file "app/controllers/start_controller.rb", "app/controllers/start_controller.rb", force: true
        directory "app/views", "app/views", force: true
        directory "config/locales", "config/locales", force: true
        copy_file "config/routes.rb", "config/routes.rb", force: true
        puts "Start controller and views generated."
      end
    end
  end
end
