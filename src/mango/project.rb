require_relative 'profile'
module Mango
  class Project
    def self.load(path)
      Profile.new(path)
    end

    def initialize path
      @path = path
    end

    def contracts
      FileExplorer.read_json("#{@path}/mango.json")["contracts"]
    end
  end
end