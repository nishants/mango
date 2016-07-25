require "json"

module Mango
  class MangoService
    def initialize config_file_path
      @config_file_path = config_file_path
    end
    def projects
      JSON.parse(File.read(@config_file_path))["projects"]
    end
  end
end
