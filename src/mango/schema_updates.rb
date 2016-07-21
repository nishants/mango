require 'pathname'

class SchemaUpdates

  def self.insert (field_id, value, json)
    fields = field_id.split(".")
    pointer = json
    fields.slice(0, fields.length-1).each{|field|
      if(pointer[field].nil?)
        return
      end
      pointer = pointer[field]
    }
    pointer[fields.last] = value
  end

  def self.rename (field_id, rename_to, json)
    fields = field_id.split(".")
    pointer = json
    fields.slice(0, fields.length-1).each{|field|
      if(isArrayField(field))
        array = pointer[field.sub("[]", "").strip()];
        field_substring_id = field_id.split(field+".")[1].strip()
        if array.nil?
          return
        end
        array.each{|element|
          rename(field_substring_id, rename_to, element);
        }
        return
      end
      if(pointer[field].nil?)
        return
      end
      pointer = pointer[field]
    }
    value = pointer[fields.last]
    pointer.delete(fields.last)
    pointer[rename_to] = value
  end

  def self.sampleFrom field, pointer
    return pointer[field.sub("[]", "").strip()][0]
  end

  def self.isArrayField field
    return field.include? "[]"
  end

  def self.remove (field_id, json)
    fields = field_id.split(".")
    pointer = json
    fields.slice(0, fields.length-1).each{|field|
      if(pointer[field].nil?)
        return
      end
      pointer = pointer[field]
    }
    pointer.delete(fields.last)
  end
end


