require './src/server/mango_service'
require 'tempfile'
require 'rspec'
require './test/test_helper'

RSpec.describe Mango::MangoService do

  describe "Import New Project" do

    def absolute_path path
      return Pathname.new(path).realpath.to_s
    end

    before(:each) do
      @test_helper = Mango::TestHelper.new
      @config_file = "#{@test_helper.test_data}/empty-config-file.json"
      @empty_project_path = "#{@test_helper.test_data}/new-project";
      @service = Mango::MangoService.new(@config_file)

      @project_name = "project-name"
      @project_path = @empty_project_path

      @service.add_project(@project_name, @empty_project_path)
    end

    it "should add project to existing list of projects" do
      expect(@service.projects).to eq([{"name" => @project_name, "path" => @project_path}])
    end

    it "should discover contracts in new project" do
      contracts_paths = @service.contracts(@project_name).map{|contract| contract["path"]}
      expected_contract_paths = ["home.json", "companies/all.json"]

      expect(contracts_paths).to match_array(expected_contract_paths)
    end

    it "should set default names for contracts" do
      contracts_paths = @service.contracts(@project_name).map{|contract| contract["name"]}
      expected_contract_paths = ["home", "companies-all"]

      expect(contracts_paths).to match_array(expected_contract_paths)
    end

  end

end