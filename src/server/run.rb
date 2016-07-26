require 'sinatra'
require 'pathname'

require_relative '../mango/project'
require_relative '../config'
require_relative 'mango_service'

PROFILE_HOME = "samples/profiles"
Profiles = Mango::Project.load(PROFILE_HOME)

service = Mango::MangoService.new "config/projects.json"
set :port, 3000
set :public_folder, 'public'

get '/' do
  File.read 'public/index.html'
end

get '/projects' do
  service.projects.to_json
end

put '/projects/import' do
  Mango::Project.import_project(params[:name], params[:path]).to_json
end

get '/schema' do
  schema = JSON.parse(File.read("#{PROFILE_HOME}/mango.json"))
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



