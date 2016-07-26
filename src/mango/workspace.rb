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
      project = projects.find { |p| p["name"] == project_name }
      unless project.nil?
        path = project["path"]
        return Project.new(path)
      end
    end

    def project_paths
      projects.map{ |project| project["path"]}
    end

  end
end