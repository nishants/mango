require_relative 'profile'
require_relative 'profile_data'
require_relative 'contract'

module Mango
  class Project
    attr_accessor :project_path
    attr_accessor :description
    attr_accessor :name

    def initialize name, path, description
      @project_path = path
      @description = description
      @name = name
      @config_file_path = "#{path}/mango.json"
      FileExplorer.if_exists(config_file) or save_contracts(Contract.scan_profiles_at @project_path)
    end

    def contracts
      contracts  = FileExplorer.read_json(config_file)["contracts"]
      scanned_contracts = Mango::Contract.scan_profiles_at(@project_path)
      scanned_contracts.each{|scanned_contract|
        isNew = contracts.find{|contract| contract["path"] == scanned_contract["path"]}.nil?
        if isNew
          contracts.push(scanned_contract)
        end
      }
      save_contracts contracts
      contracts
    end

    def save_contracts contracts
      FileExplorer.save_json(config_file, {"contracts" => contracts})
    end

    def config_file
      "#{@project_path}/mango.json"
    end

    def self.parse(json)
      if(json.nil?)
        return nil
      end
      Project.new(json["name"], json["path"], json["description"])
    end

    def self.load(path)
      Profile.new(path)
    end

    def profiles
      Dir["#{@project_path}/*/"].map{|profile_path|
        ProfileData.load(profile_path)
      }
    end
  end
end