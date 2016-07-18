class Schema
  def collections
    Class.new {
      def add config
        puts "adding collection : #{config.to_s}"
      end
    }.new
  end


  def self.create(config)
    puts "createing schema : #{config.to_s}"
     Schema.new
  end

end