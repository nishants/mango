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
end