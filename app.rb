require "sinatra"
if development?
  require "sinatra/reloader"
end

require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "photo_gallery"
)

class Gallery < ActiveRecord::Base
  has_many(:images)
end

class Image < ActiveRecord::Base
end

get "/" do
  @galleries = Gallery.all
  erb :home
end

get "/galleries/new" do
  erb :new_gallery
end

post "/galleries" do
  new_gallery_name = params[:gallery][:name]
  Gallery.create({name: new_gallery_name})
  redirect to("/")
end

patch "/galleries/:id" do
  id = params[:id]
  @gallery = Gallery.find(id)
  @gallery.update({name: params[:gallery][:name]})
  redirect(to("/galleries/#{id}"))
end

delete "/galleries/:id" do
  id = params[:id]
  gallery = Gallery.find(id)
  gallery.destroy
  redirect to "/"
end

delete "/galleries/:gallery_id/images/:image_id" do
  gallery_id = params[:gallery_id]
  image_id = params[:image_id]
  gallery = Gallery.find(gallery_id)
  image = gallery.images.find(image_id)
  image.destroy
  redirect to "/galleries/#{gallery.id}"
end

get "/galleries/:id" do
  id = params[:id]
  @gallery = Gallery.find(id)
  @name = @gallery.name
  erb :galleries
end

get "/galleries/:id/edit" do
  id = params[:id]
  @gallery = Gallery.find(id)
  erb :edit_gallery
end

get "/galleries/:id/images/new" do
  id = params[:id]
  @gallery = Gallery.find(id)
  erb :new_image
end

post "/galleries/:id/images" do
  id = params[:id]
  gallery = Gallery.find(id)
  gallery.images.create({name: params[:image][:name], url: params[:image][:url]})
  redirect to "/galleries/#{id}"
end

get "/galleries/:gallery_id/images/:image_id/edit" do
  @gallery = Gallery.find(params[:gallery_id])
  @image = @gallery.images.find(params[:image_id])
  erb :edit_image
end


patch "/galleries/:gallery_id/images/:image_id" do
  gallery = Gallery.find(params[:gallery_id])
  image = gallery.images.find(params[:image_id])
  image.update(params[:image])
  redirect to "/galleries/#{gallery.id}"
end





