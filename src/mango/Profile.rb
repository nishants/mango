require 'pathname'
require 'json'
require_relative 'document'

class Profile

  def initialize path
    @path = path
    @schema = JSON.parse(File.read("#{@path}/schema.json"))
  end

  def all
    profiles =  []
    each_profile(){|profile|
      profiles.push(profile);
    }
    profiles
  end

  def find name
    each_profile(){|profile_json, profile_root|
      if(profile_json["name"] == name)
        result = {}
        result["name"]        = profile_json["name"]
        result["description"] = profile_json["description"]
        @schema["files"].each{|file|
          result[file["name"]] = Document.new(profile_root, file['path'])
        }
        return result
      end
    }
    nil
  end

  def each_profile
    Dir["#{@path}/*/"].each{ |profile|
      profile_json = "#{profile}profile.json"
      profile_root = "#{profile_json.sub("profile.json", "").strip()}"
      if Pathname.new(profile_json).exist?
        yield(JSON.parse(File.read(profile_json)), profile_root)
      end
    }
  end
end


