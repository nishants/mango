require 'json'
require_relative 'schema_instance'
require 'pathname'

class Schema

  def initialize definition
    @definition = definition
  end

  def load path
    collections = {}
    @definition["collections"].each{|collection|
      collections[collection["name"]] = JSON.parse(IO.read("#{path}#{collection['path']}"))
    }
    SchemaInstance.load(collections)
  end

  def self.create(config)
    definition = config[:file] ? JSON.parse(File.read(config[:file])) : config[:definition]
    Schema.new(definition);
  end

  def update args
    Dir["#{args[:path]}/*/"].each{|profile|
      @definition["collections"].each {|collection|
        target_file = "#{profile.chomp(File::SEPARATOR)}#{collection['path']}"
        if(collection["name"] == args[:collection] && Pathname.new(target_file).exist?)

          contents = JSON.parse(File.read(target_file))
          contents["data"][args[:rename_to]] = contents["data"]["message"]
          contents["data"].delete("message")
          File.open(target_file, 'w'){|file|
            file.write(contents.to_json() )
          }
        end
      }
    }
  end
end