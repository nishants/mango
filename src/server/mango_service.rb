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

    def profiles_of(project_name)
      @workspace.find(project_name).profiles.map{|profile|
        profile.to_json
      }
    end

    def update_profile(project_name, profile_id, params)
      profile = find_profile(project_name, profile_id)
      profile.update(params)
    end

    def find_profile(project_name, profile_id)
      @workspace.find(project_name).profiles.find{|p|
        p.id == profile_id
      }
    end

    def profile_contracts(project_name, profile_id)
      project = @workspace.find(project_name)
      contracts = project.contracts
      profile = find_profile(project_name, profile_id)

      {"contracts" => profile.contracts(contracts)}
    end

    def get_contract (project_name, contract_name)
     contracts(project_name).find{|contract|
        contract["name"] == contract_name
      }
    end

    def contract_file(project_name, profile_id, contract_name)
      contract = get_contract(project_name, contract_name)
      find_profile(project_name, profile_id).read_contract(contract["path"])
    end

    def save_contract_file(project_name, profile_id, contract_name, json)
      contract = get_contract(project_name, contract_name)
      find_profile(project_name, profile_id).save_contract(contract["path"], json)
    end

    def update_contract_schema(project_name, contract_name, updates)
      project = find(project_name)
      Mango::Project.load(project["path"]).updateSchema(contract_name, updates)
    end
  end
end
