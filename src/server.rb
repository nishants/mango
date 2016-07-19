require 'sinatra'
require_relative 'mango/profiles'

Profiles = Profiles.load("samples/profiles")

set :port, 3000

get '/' do
  File.read 'public/index.html'
end

get '/profiles' do
  Profiles.all().to_json
end

get '/profiles/:name/:file' do
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

