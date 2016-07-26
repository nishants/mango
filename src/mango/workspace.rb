require_relative "file_explorer"
module Mango
  class WorkSpace

    def initialize config_file_path
      @config_file_path = config_file_path
    end

    def projects
      FileExplorer.read_json(@config_file_path)["projects"]
    end

    def add_project  name, path
      config = FileExplorer.read_json @config_file_path;
      config["projects"].push({"name" => name, "path" => path})
      FileExplorer.save_json @config_file_path, config
    end

    def find project_name
      path = projects.find { |p| p["name"] = project_name }["path"]
      Project.new path
    end

  end
end