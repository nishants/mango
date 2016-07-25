require File.expand_path '../test_helper.rb', __FILE__

class MyTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_get_projects
    get '/projects'
    assert last_response.ok?
    assert_equal [{"name" => "sample", "path" => "samples/profiles"}], JSON.parse(last_response.body)
  end

  def test_import_existing_project

  end

  def test_import_new_project
    new_project_path = "/Users/dawn/Documents/projects/schemer/test/data/import-new-project"
    new_project_name = "new-project"

    expected_response = {"name" => new_project_name, "path" => new_project_path, "files" => ["/home.json", "/companies/all.json"]}

    put '/projects/import', {"name" => new_project_name, "path" => new_project_path}
    assert last_response.ok?
    assert_equal JSON.parse(last_response.body), expected_response

    # get '/projects'
    # assert last_response.ok?
    # assert_equal [{"name" => "sample", "path" => "samples/profiles"}, {"name" => new_project_name, "path" => new_project_path}], JSON.parse(last_response.body)
  end

end