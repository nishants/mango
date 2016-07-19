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
     Schema.new(JSON.parse(File.read(config[:file])));
  end

end