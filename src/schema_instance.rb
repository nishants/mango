require 'json'

class SchemaInstance

  def self.load(definition, path)
    Class.new{
      def initialize(definition, path)
        definition["collections"].each { |collection|
          value = {"data" => {"message" => "hello"}}
          instance_variable_set("@#{collection["name"]}", value)
          self.class.send(:attr_accessor, collection["name"])
        }
      end
    }.new(definition, path)
  end

end