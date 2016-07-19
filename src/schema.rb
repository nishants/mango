require 'json'
require_relative 'schema_instance'

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
    @definition["collections"].each {|collection|
      if(collection["name"] == args[:collection])

        target_file = "#{args[:path]}/1011#{collection['path']}"
        contents = JSON.parse(File.read(target_file))

        contents["data"][args[:rename_to]] = contents["data"]["message"]
        contents["data"].delete("message")
        File.open(target_file, 'w'){|file|
          file.write(contents.to_json() )
        }
      end
    }

    args[:path]

  end
end