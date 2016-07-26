module Mango
  class Contract
    def self.path_to_url(path)
      path.gsub(File::SEPARATOR, "-").gsub(".json", "")
    end

    def self.scan_profiles_at(path)
      relative_paths = {}

      Dir["#{path}/*/"].each{|profile_base|
        FileExplorer.each_json(profile_base){|file|
          relative_paths[Pathname.new(file).relative_path_from(Pathname.new profile_base).to_s] = true
        }
      }
      relative_paths.keys.map{|relative_path|
        {"name" => Contract.path_to_url(relative_path), "path" => relative_path}
      }
    end

  end
end