require "json"

module Mango
  class MangoService
    def initialize config_file_path
      @config_file_path = config_file_path
    end
    def projects
      JSON.parse(File.read(@config_file_path))["projects"]
    end
    def add_project name, path
      config = JSON.parse(File.read(@config_file_path));
      config["projects"].push({"name" => name, "path" => path})
      File.open(@config_file_path, 'w'){|file|
        file.write(config.to_json() )
      }
    end
  end
end
