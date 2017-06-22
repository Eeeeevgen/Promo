class MainController < ApplicationController
  def index
    puts '111'
    puts Image.last.image.url
    puts '222'
    @image = Image.last.image.url
  end

  def image
    puts 'upload!'
    p = Image.new
    p.image = params[:image]
    p.save!
    # p.image.scale(100, 100)
    # puts p.image.url # => '/url/to/file.png'
    # puts p.image.current_path # => 'path/to/file.png'
    # puts p.image_identifier # => 'file.png'
    @image = Image.last.image.url
    render :index
  end
end
