require_relative "file_explorer"
module Mango
  class WorkSpace

    def initialize config_file_path
      @config_file_path = config_file_path
    end

    def projects
      FileExplorer.read_json(@config_file_path)["projects"]
    end

    def add_project  name, path, description
      config = FileExplorer.read_json @config_file_path;
      config["projects"].push({"name" => name, "path" => path, "description" => description})
      FileExplorer.save_json @config_file_path, config
    end

    def find project_name
      project = projects.find { |p| p["name"] == project_name }
      unless project.nil?
        return Project.parse(project)
      end
    end

    def project_paths
      projects.map{ |project| project["path"]}
    end

    def remove name
      config = FileExplorer.read_json @config_file_path;
      config["projects"] = config["projects"].select{|project| project["name"] != name}
      FileExplorer.save_json @config_file_path, config
    end

    def update_project name, params
      project = projects.find { |p| p["name"] == name };
      project["name"] =  params["name"]
      project["description"] =  params["description"]
      remove(name);
      add_project(params["name"], project["path"], params["description"])
    end

  end
end