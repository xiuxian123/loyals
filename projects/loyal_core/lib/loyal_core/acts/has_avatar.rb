# -*- encoding : utf-8 -*-
module LoyalCore
  module ActsAsHasAvatar
    # LOYAL_CORE_AVATAR_STYLES = {
    #   :medium => "360x360#",
    #   :small  => "180x180#",
    #   :thumb  => "100x100#",
    #   :mini   => "50x50#"
    # }.freeze

    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      # 
      #
      def loyal_core_acts_as_has_avatar(*args)
        options = args.extract_options!

        field_name = args.first || :avatar

        attr_accessible field_name, :"#{field_name}_cache"
        mount_uploader field_name, ::LoyalCore::AvatarUploader
      end
    end
  end
end

