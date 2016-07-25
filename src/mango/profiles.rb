require_relative 'profile'
module Mango
  class Profiles
    def self.load(path)
      Profile.new(path)
    end
    def self.import_project(name, path)
      {"name" => "new-project", "path" => "/Users/dawn/Documents/projects/schemer/test/data/import-new-project", "files" => ["/home.json", "/companies/all.json"]}
    end

  end
end