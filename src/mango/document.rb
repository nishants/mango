require 'pathname'
require_relative 'mapper'

class Document
  attr_accessor :content

  def initialize (profile_root, relative_path)
    json_file   = "#{profile_root.chomp(File::SEPARATOR)}#{relative_path}"
     @content   = JSON.parse(File.read(json_file))
  end
end


