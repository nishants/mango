require './src/mango/contract'
require './src/mango/file-explorer'

module Mango
  class MangoService

    def initialize config_file_path
      @config_file_path = config_file_path
    end

    def projects
      FileExplorer.read_json(@config_file_path)["projects"]
    end

    def add_project name, path
      config = FileExplorer.read_json @config_file_path;
      config["projects"].push({"name" => name, "path" => path})
      FileExplorer.save_json @config_file_path, config

      if(!FileExplorer.if_exists "#{path}/mango.json")
        create_project name, path
      end
    end

    def contracts(project_name)
      path = projects.find { |p| p["name"] = project_name }["path"]
      FileExplorer.read_json("#{path}/mango.json")["contracts"]
    end

    def create_project name, path
      project = {"name" => name, "contracts" => []}
      relative_paths = {}
      Dir["#{path}/*/"].each{|profile|
        FileExplorer.each_json(profile){|file|
          relative_paths[Pathname.new(file).relative_path_from(Pathname.new profile).to_s] = true
        }
      }
      project["contracts"] = relative_paths.keys.map{|relative_path|
        {"name" => Contract.path_to_url(relative_path), "path" => relative_path}
      }
      FileExplorer.save_json "#{path}/mango.json", project
    end

  end
end
