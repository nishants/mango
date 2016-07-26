require './src/server/mango_service'
require 'tempfile'
require 'rspec'
require './test/test_helper'

RSpec.describe Mango::MangoService do

  describe "MangoService" do

    def absolute_path path
      return Pathname.new(path).realpath.to_s
    end

    before(:each) do
      @test_helper = Mango::TestHelper.new
      @config_file = "#{@test_helper.test_data}/sample-config-file.json"
      @empty_project_path = "#{@test_helper.test_data}/new-project";
      @existing_project = @test_helper.read_json(@config_file)["projects"][0]
      @service = Mango::MangoService.new(@config_file)
    end

    it "should return all projects" do
      expect(@service.projects).to eq([{"name"=>"sample", "path"=>"samples/profiles"}])
    end

    it "should return project by name" do
      expect(@service.find("not-exists").nil?).to eq(true)
      expect(@service.find("sample")["path"]).to eq("samples/profiles")
    end

    it "should add new project" do
      project_name = "project-name"
      project_path = @empty_project_path

      @service.import(project_name, @empty_project_path)
      expect(@service.projects).to eq([@existing_project, {"name" => project_name, "path" => project_path}])

      contracts_paths = @service.contracts(project_name).map{|contract| contract["path"]}
      expected_contract_paths = ["home.json", "companies/all.json"]

      expect(contracts_paths).to match_array(expected_contract_paths)
    end

  end

end