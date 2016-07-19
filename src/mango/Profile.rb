require 'pathname'
require_relative 'mapper'

class Profile

  def initialize path
    @path = path
  end

  def all
    profiles =  []
    each_profile(){|profile|
      profiles.push(profile);
    }
    profiles
  end

  def find name
    each_profile(){|profile|
      if(profile["name"] == name)
        return Mapper.parse({
                "name"        => profile["name"],
                "description" => profile["description"]}
        )
      end
    }
    nil
  end

  def has_file relative_path
    file_path = "#{@path}#{relative_path}"
    File.exists? file_path
  end

  def each_profile
    Dir["#{@path}/*/"].each{ |profile|
      profileJson = "#{profile}profile.json"
      if Pathname.new(profileJson).exist?
        yield(JSON.parse(File.read(profileJson)))
      end
    }
  end
end


