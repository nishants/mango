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

  def update params
    config = JSON.parse(File.read(@config))
    config["name"]        = params["name"]
    config["description"] = params["description"]
    Mango::FileExplorer.save_json(@config, config)
  end

  def name
    JSON.parse(File.read(@config))["name"]
  end

  def id
    File.basename(@path)
  end

  def read_contract(relative_path)
    contract_path = "#{@path}#{relative_path}"
    if Mango::FileExplorer.if_exists(contract_path)
      Mango::FileExplorer.read_json(contract_path)
    end
  end

  def contracts(project_contracts)
    project_contracts.map{|contract|
      exists = Mango::FileExplorer.if_exists("#{@path}/#{contract["path"]}")
      {"name" => contract["name"], "present" => exists}
    }
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


