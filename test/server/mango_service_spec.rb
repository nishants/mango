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
      @config_file = "#{@test_helper.test_data}/empty-config-file.json"
      @empty_project_path = "#{@test_helper.test_data}/new-project";
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

      contracts = @service.contracts project_name
      exected_contracts = [
          {"name"        =>  "home",
          "description"  => "response for users-service/<user-id>/home",
          "path"         => "/home.json"}, {
          "name"         => "companies",
          "description"  => "response for quote-service/user/<user-id>/company",
          "path"         => "/companies/all.json"}]

      # expect(contracts).to eq(exected_contracts)
    end

  end

end