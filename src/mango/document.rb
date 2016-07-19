require 'pathname'

class Document
  attr_accessor :content

  def initialize (profile_root, relative_path)
    @file     = "#{profile_root.chomp(File::SEPARATOR)}#{relative_path}"
    @content  = JSON.parse(File.read(@file))
  end

  def save
    File.open(@file, 'w'){|file|
      file.write(@content.to_json() )
    }
  end
end


