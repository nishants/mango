require 'sinatra'
require 'pathname'

require_relative 'mango/profiles'
require_relative 'config'

PROFILE_HOME = "samples/profiles"
Profiles = Mango::Profiles.load(PROFILE_HOME)

set :port, 3000
set :public_folder, 'public'

get '/' do
  File.read 'public/index.html'
end

get '/projects' do
  MangoConfig.projects.to_json
end

put '/projects/import' do
  Mango::Profiles.import_project(params[:name], params[:path]).to_json
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

put '/profiles/apply-to-all/files/:file' do
  file_content =  JSON.parse request.body.read
  Profiles.updateAllFiles(params[:file], file_content)
end

put '/profiles/:name/files/:file' do
  file_content =  JSON.parse request.body.read
  document = Profiles.find(params[:name])[params[:file]]
  document.content = file_content
  document.save
  Profiles.find(params[:name])[params[:file]].content.to_json
end

put '/profiles/files/:file/update-schema' do
  udpates =  JSON.parse request.body.read
  Profiles.updateSchema(params[:file], udpates)
end



