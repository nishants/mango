require './src/mango/contract'
require './src/mango/file_explorer'
require './src/mango/workspace'
require './src/mango/project'

module Mango
  class MangoService

    def initialize(config_file_path)
      @workspace = WorkSpace.new config_file_path
    end

    def projects
      @workspace.projects
    end

    def find project_name
      project = @workspace.find(project_name)
      unless project.nil?
        {"name" => project_name, "path" => project.project_path}
      end
    end

    def import name, path
      exists = @workspace.project_paths.include? path
      unless exists
        @workspace.add_project(name, path)
      end
      Project.new(path).contracts
    end

    def contracts(project_name)
      @workspace.find(project_name).contracts
    end

  end
end
