require 'pathname'
require_relative 'schema_updates'

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

  def updateSchema(updateSchema)
    updateSchema.each{|update|
      isRename = !update["renameTo"].nil?
      isInsert = !update["insert"].nil?
      isRemove = !update["remove"].nil?

      isRename && SchemaUpdates.rename(update["field"] , update["renameTo"] , @content)
      isInsert && SchemaUpdates.insert(update["insert"], update["value"]    , @content)
      isRemove && SchemaUpdates.remove(update["remove"], @content)
    }
  end
end


