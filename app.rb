require "sinatra"
if development?
  require "sinatra/reloader"
end

require "pg"

database = PG.connect({dbname: "photo_gallery"})

get "/" do
  results = database.exec_params("SELECT name FROM galleries")
  @gallery_names = []
  results.each do |result|
    @gallery_names << result["name"]
  end
  erb :home
end

get "/galleries/:name" do
  @name = params[:name]
  @images = @gallery_names[@name]
  erb :galleries
end
