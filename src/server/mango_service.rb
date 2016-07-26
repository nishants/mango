require './src/mango/contract'
require './src/mango/file_explorer'
require './src/mango/workspace'

module Mango
  class MangoService

    def initialize config_file_path
      @workspace = WorkSpace.new config_file_path
    end

    def projects
      @workspace.projects
    end

    def add_project name, path
      @workspace.add_project name, path
      if(!FileExplorer.if_exists "#{path}/mango.json")
        create_project name, path
      end
    end

    def contracts(project_name)
      @workspace.find(project_name).contracts
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
