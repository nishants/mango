module Mango
  class Contract
    def self.path_to_url path
      return path.gsub(File::SEPARATOR, "-").gsub(".json", "")
    end
  end
end