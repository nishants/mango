CONFIG_FILE = "config/projects.json"

class MangoConfig
  def self.projects
    JSON.parse(File.read(CONFIG_FILE))["projects"]
  end
end