require 'json'

class SchemaInstance

  def self.load(collections)
    Class.new{
      def initialize(collections)
        collections.each { |name, value|
          instance_variable_set("@#{name}", value)
          self.class.send(:attr_accessor, name)
        }
      end
    }.new(collections)
  end

end