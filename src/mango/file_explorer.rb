require "json"
require 'pathname'
require 'find'
require 'fileutils'

module Mango
  class FileExplorer
    def self.each_json path
      Find.find(path) {|file|
        if(file.to_s.end_with? ".json")
          yield(File.new(file).path)
        end
      }
    end

    def self.read_json file
      JSON.parse(File.read(file))
    end

    def self.save_json file , content
      dir = File.dirname(file)

      unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
      end

      File.open(file, 'w'){|file|
        file.write(content.to_json)
      }
    end

    def self.if_exists file
      Pathname.new(file).exist?
    end


  end
end