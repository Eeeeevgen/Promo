class ImagesController < ApplicationController
  def new
    puts 'upload!'
    # p = Image.new
    # p.image = params[:image]
    # p.save!
    # # p.image.scale(100, 100)
    # # puts p.image.url # => '/url/to/file.png'
    # # puts p.image.current_path # => 'path/to/file.png'
    # # puts p.image_identifier # => 'file.png'
    # @image = Image.last && Image.last.image.url
    # render :index

    i = current_user.images.new
    i.image = params[:image]
    i.save!
    redirect_to "users/show"
  end
end