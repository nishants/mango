require 'pathname'

class SchemaUpdates

  def self.insert (field_id, value, json)
    fields = field_id.split(".")
    pointer = json
    fields.slice(0, fields.length-1).each{|field|
      pointer = pointer[field]
    }
    pointer[fields.last] = value
  end
end


