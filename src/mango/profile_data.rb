require 'pathname'
require 'json'
require_relative 'document'
require_relative 'file_explorer'

class ProfileData

  def initialize path
    @path = path
    @config = "#{path}profile.json"
  end

  def self.load path
    config_file = "#{path}profile.json"
    if !Mango::FileExplorer.if_exists(config_file)
      Mango::FileExplorer.save_json(config_file, {"id" => File.basename(path), "name" => "", "description" => "", "contracts" => []})
    end
    ProfileData.new(path)
  end

  def to_json
    JSON.parse(File.read("#{@path}profile.json"))
  end
end


