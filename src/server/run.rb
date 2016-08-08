require 'sinatra'
require 'pathname'
require 'open-uri'
require_relative '../mango/file_explorer'

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

put '/projects/:project_name/import' do
  path = JSON.parse(request.body.read)["path"]
  exists = service.find(params[:project_name])

  unless Mango::FileExplorer.if_exists(path)
    status 404
    return {"error" => "Path not found : #{path}"}.to_json
  end
  unless exists.nil?
    status 409
    return {"error" => "Path already exists : #{path}"}.to_json
  end

  service.import(params[:project_name], path, params[:description]).to_json
end

get '/projects/:project_name/contracts' do
  service.contracts(params[:project_name]).to_json
end

put '/projects/:project_name' do
  update_params = JSON.parse(request.body.read);
  service.update(params[:project_name], update_params).to_json
end

put '/projects/:project_name/remove' do
  service.remove(params[:project_name])
  {}
end

get '/projects/:project_name/profiles' do
  service.profiles_of(params[:project_name]).to_json
end

put '/projects/:project_name/profiles/:profile_id' do
  update_params = JSON.parse(request.body.read);
  service.update_profile(params[:project_name], params[:profile_id], update_params)
  {}
end

get '/projects/:project_name/profiles/:profile_id/contracts' do
  service.profile_contracts(params[:project_name], params[:profile_id])["contracts"].to_json
end

get '/projects/:project_name/profiles/:profile_id/contracts/:contract_id' do
  service.contract_file(params[:project_name], params[:profile_id], params[:contract_id]).to_json
end

put '/projects/:project_name/profiles/:profile_id/contracts/:contract_id' do
  contract = JSON.parse(request.body.read);
  service.save_contract_file(params[:project_name], params[:profile_id], params[:contract_id], contract).to_json
  {}
end

put '/projects/:project_name/contracts/:contract_id/update-schema' do
  updates =  JSON.parse request.body.read
  project = service.update_contract_schema(params[:project_name], params[:contract_id], updates)
  {}
end

# *******************************************************
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



