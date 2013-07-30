# -*- encoding : utf-8 -*-

module LoyalCore
  class AvatarUploader < ::LoyalCore::AssetUploader
    include ::CarrierWave::MiniMagick

    # 只能上传图片
    def extension_white_list
      LOYAL_CORE_UPLOADER_IMAGE_EXT
    end

    version :medium do
      process :resize_to_fill => [360, 360]
    end

    version :small do
      process :resize_to_fill => [180, 180]
    end

    version :thumb do
      process :resize_to_fill => [100, 100]
    end

    version :mini do
      process :resize_to_fill => [50, 50]
    end

    version :tiny do
      process :resize_to_fill => [32, 32]
    end

    version :ico do
      process :resize_to_fill => [16, 16]
    end

  end
end
