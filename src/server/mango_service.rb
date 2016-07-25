require "json"

module Mango
  class MangoService

    def initialize config_file_path
      @config_file_path = config_file_path
    end

    def read_json file
      JSON.parse(File.read(file))
    end

    def projects
      read_json(@config_file_path)["projects"]
    end

    def add_project name, path
      config = JSON.parse(File.read(@config_file_path));
      config["projects"].push({"name" => name, "path" => path})
      File.open(@config_file_path, 'w'){|file|
        file.write(config.to_json() )
      }
    end

    def contracts(project_name)
      path = projects.find { |p| p["name"] = project_name }["path"]
      read_json "#{path}/schema.json"
    end
  end
end
