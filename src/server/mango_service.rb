require './src/mango/contract'
require './src/mango/file_explorer'
require './src/mango/workspace'

module Mango
  class MangoService

    def initialize(config_file_path)
      @workspace = WorkSpace.new config_file_path
    end

    def projects
      @workspace.projects
    end

    def add_project name, path
      project = @workspace.add_project name, path
      Project.new(path).import
    end

    def contracts(project_name)
      @workspace.find(project_name).contracts
    end

  end
end
