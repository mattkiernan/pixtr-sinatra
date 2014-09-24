require "sinatra"
if development?
  require "sinatra/reloader"
end

require "pg"

database = PG.connect({dbname: "photo_gallery"})

get "/" do
  galleries = database.exec_params("SELECT name  FROM galleries")
  @gallery_names = galleries.map {|result| result["name"]}
  erb :home
end

get "/galleries/:id" do
  id = params[:id]
  results = database.exec_params("SELECT name  FROM galleries WHERE id = $1", [id])
  @gallery_name = results.first["name"]
  erb :galleries
end
