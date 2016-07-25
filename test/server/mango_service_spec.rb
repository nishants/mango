require './src/server/mango_service'
require 'tempfile'
require 'rspec'

RSpec.describe Mango::MangoService do

  describe "MangoService" do

    def absolute_path path
      return Pathname.new(path).realpath.to_s
    end

    before(:each) do
      @config_file = "test/data/empty-config-file.json"
      @empty_project_path = absolute_path "test/data/new-project";
      @service = Mango::MangoService.new(@config_file)
    end

    it "should return all projects" do
      expect(@service.projects).to eq([])
    end

    it "should add new project" do
      project_name = "project-name"
      project_path = @empty_project_path

      @service.add_project(project_name, @empty_project_path)
      expect(@service.projects).to eq([{"name" => project_name, "path" => project_path}])
    end

  end

end