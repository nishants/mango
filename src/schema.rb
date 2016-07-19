class Schema

  def initialize config
    puts "creating schema : #{config.to_s}"
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
     Schema.new(config)
  end

end