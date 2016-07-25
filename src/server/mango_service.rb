require "json"
require 'pathname'

module Mango
  class MangoService

    def initialize config_file_path
      @config_file_path = config_file_path
    end

    def if_exists file
      Pathname.new(file).exist?
    end

    def read_json file
      JSON.parse(File.read(file))
    end

    def save_json file , content
      File.open(file, 'w'){|file|
        file.write(content.to_json)
      }
    end

    def projects
      read_json(@config_file_path)["projects"]
    end

    def create_project path
      save_json "#{path}/mango.json", {"contracts" => [
          {"name"        =>  "home",
           "description"  => "response for users-service/<user-id>/home",
           "path"         => "/home.json"}, {
              "name"         => "companies",
              "description"  => "response for quote-service/user/<user-id>/company",
              "path"         => "/companies/all.json"}]}
    end

    def add_project name, path
      config = JSON.parse(File.read(@config_file_path));
      config["projects"].push({"name" => name, "path" => path})
      File.open(@config_file_path, 'w'){|file|
        file.write(config.to_json() )
      }
      project_settings = "#{path}/mango.json"
      if(!if_exists project_settings)
        create_project path
      end
    end

    def contracts(project_name)
      path = projects.find { |p| p["name"] = project_name }["path"]
      read_json("#{path}/mango.json")["contracts"]
    end
  end
end
