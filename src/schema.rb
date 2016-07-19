require 'json'

class Schema

  def initialize definition
    puts "creating schema : #{definition}"
  end

  def load(path)
    Class.new {
      attr_reader :home
      def initialize
        @home = {"data" => {"message" => "hello"}}
      end
    }.new
  end

  def self.create(config)
     schema_definition = JSON.parse(File.read(config[:file]))
     Schema.new(schema_definition);
  end

end