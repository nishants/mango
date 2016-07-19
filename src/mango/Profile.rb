require 'pathname'

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

  def find id
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


