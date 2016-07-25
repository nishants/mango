require './src/server/mango_service'
require 'tempfile'
require 'rspec'

RSpec.describe Mango::MangoService do

  describe "MangoService" do

    before(:all) do
      @config_file = "test/data/empty-config-file.json"
      @empty_prolect_path = "test/data/new-project";
      @service = Mango::MangoService.new(@config_file)
    end

    it "should return all projects" do
      expect(@service.projects).to eq([])
    end

    it "should add new project" do
      expect(@service.projects).to eq([])
      @service.projects.add("project-name", "")
      expect(@service.projects).to eq([])
    end

  end

end