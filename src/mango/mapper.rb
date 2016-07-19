class Mapper
  def self.parse(collections)
    Class.new{
      def initialize(collections)
        collections.each { |name, value|
          if value.class == Hash
            value = Mapper.parse(value);
          end

          instance_variable_set("@#{name}", value)
          self.class.send(:attr_accessor, name)
        }
      end
    }.new(collections)
  end
end