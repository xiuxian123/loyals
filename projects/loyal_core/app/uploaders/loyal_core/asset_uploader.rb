# -*- encoding : utf-8 -*-

module LoyalCore
  class AssetUploader < ::CarrierWave::Uploader::Base
    LOYAL_CORE_UPLOADER_IMAGE_EXT = %w[gif jpg jpeg png bmp]

    LOYAL_CORE_UPLOADER_FLASH_EXT = %w[swf flv]

    LOYAL_CORE_UPLOADER_MEDIA_EXT = %w[swf flv mp3 wav wma wmv mid avi mpg asf rm rmvb]

    LOYAL_CORE_UPLOADER_FILE_EXT  = %w[doc docx xls xlsx ppt htm html txt zip rar gz bz2]

    # Include RMagick or MiniMagick support:
    # include CarrierWave::RMagick
    # include CarrierWave::MiniMagick

    # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
    # include Sprockets::Helpers::RailsHelper
    # include Sprockets::Helpers::IsolatedHelper

    # Choose what kind of storage to use for this uploader:
    storage :file
    # storage :fog

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    # def store_dir
    #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    # end

    def store_dir
      # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model_id_partition}"
      "uploads/#{impl_model_name_underscore}/#{mounted_as}/#{impl_integer_partition(model.created_at.to_i)}"
    end

    def model_id_partition
      impl_integer_partition(model.id)
    end

    # Provide a default URL as a default if there hasn't been a file uploaded:
    # def default_url
    #   # For Rails 3.1+ asset pipeline compatibility:
    #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    #
    #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    # end

    def default_url *args
      if (version = args.first) && version.respond_to?(:to_sym)
        raise ArgumentError, "Version #{version} doesn't exist!" if versions[version.to_sym].nil?
        # recursively proxy to version
        versions[version.to_sym].default_url(*args[1..-1])
      else
        ::ActionController::Base.helpers.asset_path(
          "loyal_core/fallbacks/#{impl_model_name_underscore}/#{mounted_as}/" + [version_name, "missing.gif"].compact.join('_')
        )
      end

      # For Rails 3.1+ asset pipeline compatibility:
      # "/images/fallbacks/#{impl_model_name_underscore}/#{mounted_as}/" + ["missing.gif", version_name].compact.join('_')
    
      # "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    end

    def url *args
      stored_file_name = model.send(mounted_as)

      __url = if stored_file_name.present?
        _url = super

        _url = "#{_url}?#{impl_generate_stmap_version}" unless _url.include?('?')

        _url
      else
        default_url *args
      end

      __url = "#{::LoyalCore.config.upload_asset_server}#{__url}" unless __url.start_with?('http')

      __url
    end

    # Process files as they are uploaded:
    # process :scale => [200, 300]
    #
    # def scale(width, height)
    #   # do something
    # end

    # Create different versions of your uploaded files:
    # version :thumb do
    #   process :scale => [50, 50]
    # end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    # def extension_white_list
    #   %w(jpg jpeg gif png)
    # end

    # Override the filename of the uploaded files:
    # Avoid using model.id or version_name here, see uploader/store.rb for details.
    # def filename
    #   "something.jpg" if original_filename
    # end

    def filename
      if file
        "#{Digest::MD5.hexdigest(impl_model_hash_data)}.#{file.extension}"
      end
    end

    private

    def impl_generate_stmap_version
      "#{model.updated_at.to_i}"
    end

    def impl_model_name_underscore
      model.class.to_s.underscore
    end

    def impl_model_hash_data
      "#{model.class.to_s}-#{model.id}-#{model.created_at.to_i}-#{::LoyalCore.config.upload_asset_hash_data}"
    end

    # e.g.: 1234 => "000/000/000/000/001/234"
    def impl_integer_partition number
      ("%018d" % number).scan(/\d{3}/).join("/")
    end
  end
end

