require_relative 'profile'
module Mango
  class Project
    def self.load(path)
      Profile.new(path)
    end

    def initialize path
      @path = path
      @config_file_path = "#{path}/mango.json"
      FileExplorer.if_exists(@config_file_path) or import
    end

    def contracts
      FileExplorer.read_json(@config_file_path)["contracts"]
    end

    def import
      contracts = Contract.scan_profiles_at @path
      FileExplorer.save_json @config_file_path, {"contracts" => contracts}
    end
  end
end