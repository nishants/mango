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
      Mango::FileExplorer.save_json(config_file, {"name" => "untitled", "description" => "", "contracts" => []})
    end
    ProfileData.new(path)
  end

  def to_json
    config = JSON.parse(File.read(@config))
    {
        "id"          => File.basename(@path),
        "name"        => config["name"] ,
        "description" => config["description"]
    }
  end
end


