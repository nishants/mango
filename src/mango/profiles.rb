require_relative 'profile'
module Mango
  class Profiles
    def self.load(path)
      Profile.new(path)
    end
  end
end