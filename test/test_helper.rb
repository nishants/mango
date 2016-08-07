require './src/mango/file_explorer'

module Mango
  class TestHelper
    attr_accessor :test_data

    def temp_copy_of tempate
      path = Tempfile.new("#{Random.new(212).rand()}").path()

      FileUtils.rm_rf(path)
      FileUtils::mkdir_p path
      FileUtils.copy_entry tempate, path
      path
    end

    def test_data
       temp_copy_of "test/data"
    end

    def read_json file
       FileExplorer.read_json(file)
    end

    def save_json file, json
       FileExplorer.save_json(file, json)
    end
  end
end