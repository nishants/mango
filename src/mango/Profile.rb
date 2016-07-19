require 'pathname'
require_relative 'document'

class Profile

  def initialize path
    @path = path
    @schema = schema()
  end

  def all
    profiles =  []
    each_profile(){|profile|
      profiles.push(profile);
    }
    profiles
  end

  def find name
    each_profile(){|profile, profile_root|
      if(profile["name"] == name)
        result = {
            "name"        => profile["name"],
            "description" => profile["description"]}

        @schema["files"].each{|file|
          result[file["name"]] = Document.new(profile_root, file['path'])
        }
        return result
      end
    }
    nil
  end

  def read relative_path
    file_path = "#{@path}#{relative_path}"
    JSON.parse(File.read(file_path))
  end

  def has_file relative_path
    file_path = "#{@path}#{relative_path}"
    File.exists? file_path
  end

  def schema
    JSON.parse(File.read("#{@path}/schema.json"))
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


