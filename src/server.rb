require 'sinatra'
require 'pathname'

require_relative 'mango/profiles'

PROFILE_HOME = "samples/profiles"
Profiles = Profiles.load(PROFILE_HOME)

set :port, 3000
set :public_folder, 'public'

get '/' do
  File.read 'public/index.html'
end

get '/schema' do
  schema = JSON.parse(File.read("#{PROFILE_HOME}/schema.json"))
  schema["base"] = Pathname.new(PROFILE_HOME).realpath
  schema.to_json
end

get '/profiles' do
  Profiles.all().to_json
end

get '/profiles/:name/files/:file' do
  Profiles.find(params[:name])[params[:file]].content.to_json
end

put '/profiles/:name/:file' do
  req = JSON.parse request.body.read
  file_content =  req[params[:file]]
  document = Profiles.find(params[:name])[params[:file]]
  document.content = file_content
  document.save
  Profiles.find(params[:name])[params[:file]].content.to_json
end

