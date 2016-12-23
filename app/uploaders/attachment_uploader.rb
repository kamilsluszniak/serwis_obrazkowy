# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base
  include ActionView::Helpers::TextHelper
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  
  process resize_to_limit: [600, 1600]
  
  process :add_text
  
  if Rails.env.production?
    process :quality => 80
  else
    process :quality => 80
  end
 
  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  
  def add_text
    if model.text_bool
      @text = model.image_text
      @text = word_wrap(@text, line_width: 40)
      if file
        @width, @height = ::MiniMagick::Image.open(file.file)[:dimensions]
      end
      @size = 36 * @width / 600 
      @size = @size.round
      manipulate! do |image|
        image.combine_options do |c|
          c.gravity 'South'
          c.pointsize "#{@size}"
          c.annotate '+0+0', "#{@text}"
          c.fill 'white'
          c.stroke 'black'
          c.strokewidth '1'
          c.append
        end
      image
      end
    end    
  end

  # Create different versions of your uploaded files:
   #version :thumb do
   #  process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end


      
end
