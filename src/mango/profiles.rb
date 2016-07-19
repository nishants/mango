require_relative 'profile'

class Profiles

  def self.load(path)
    Profile.new(path)
  end

end