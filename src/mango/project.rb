require_relative 'profile'
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
      FileExplorer.if_exists(config_file) or update
    end

    def contracts
      FileExplorer.read_json(config_file)["contracts"]
    end

    def update
      contracts = Contract.scan_profiles_at @project_path
      FileExplorer.save_json(config_file, {"contracts" => contracts})
    end

    def config_file
      "#{@project_path}/mango.json"
    end

    def self.parse(json)
      Project.new(json["name"], json["path"], json["description"])
    end

    def self.load(path)
      Profile.new(path)
    end
  end
end