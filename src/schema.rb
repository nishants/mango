require_relative './collection'

class Schema
  attr_reader :collections

  def initialize config
    puts "creating schema : #{config.to_s}"
    @collections =  Collection.new
  end

  def self.create(config)
     Schema.new(config)
  end

end