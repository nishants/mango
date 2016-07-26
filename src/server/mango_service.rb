require "json"
require 'pathname'
require 'find'
require './src/mango/contract'

module Mango
  class MangoService

    def initialize config_file_path
      @config_file_path = config_file_path
    end

    def if_exists file
      Pathname.new(file).exist?
    end

    def read_json file
      JSON.parse(File.read(file))
    end

    def save_json file , content
      File.open(file, 'w'){|file|
        file.write(content.to_json)
      }
    end

    def projects
      read_json(@config_file_path)["projects"]
    end

    def create_project name, path
      project = {"name" => name, "contracts" => []}
      relative_paths = {}
      Dir["#{path}/*/"].each{|profile|
        each_json(profile){|file|
          relative_paths[Pathname.new(file).relative_path_from(Pathname.new profile).to_s] = true
        }
      }
      project["contracts"] = relative_paths.keys.map{|relative_path|
        {"name" => Contract.path_to_url(relative_path), "path" => relative_path}
      }
      save_json "#{path}/mango.json", project
    end

    def add_project name, path
      config = JSON.parse(File.read(@config_file_path));
      config["projects"].push({"name" => name, "path" => path})
      save_json @config_file_path, config

      if(!if_exists "#{path}/mango.json")
        create_project name, path
      end
    end

    def contracts(project_name)
      path = projects.find { |p| p["name"] = project_name }["path"]
      read_json("#{path}/mango.json")["contracts"]
    end

    def each_json path
      Find.find(path) {|file|
        if(file.to_s.end_with? ".json")
          yield(File.new(file).path)
        end
      }
    end
  end
end
