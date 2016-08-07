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

    def remove(project_name)
      @workspace.remove(project_name)
    end

    def find project_name
      project = @workspace.find(project_name)
      unless project.nil?
        {"name" => project_name, "path" => project.project_path, "description" => project.description}
      end
    end

    def import name, path, description
      exists = @workspace.project_paths.include? path
      unless exists
        @workspace.add_project(name, path, description)
      end
      Project.new(name, path, description).contracts
    end

    def contracts(project_name)
      @workspace.find(project_name).contracts
    end

    def update(project_name, params)
      @workspace.update_project(project_name, params)
    end

  end
end
