require 'json'
require_relative 'schema_instance'

class Schema

  def initialize definition
    @definition = definition
  end

  def load path
    SchemaInstance.load(@definition, path)
  end

  def self.create(config)
     Schema.new(JSON.parse(File.read(config[:file])));
  end

end