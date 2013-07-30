# -*- encoding : utf-8 -*-
# usage:
#  include LoyalCore::ActsAsUUIDFul
module LoyalCore
  module ActsAsUUIDFul
    def self.included(base)
      base.class_eval do
        extend  ClassMethods
        include InstanceMethods

        after_initialize do |r|
          r.impl_loyal_core_uuid_generate
        end

        validates_uniqueness_of :uuid
        validates_presence_of   :uuid
      end
    end

    module ClassMethods
      def uuid_rebuild!
        self.all.each do |item|
          item.impl_loyal_core_uuid_generate false
          item.save
        end
      end
    end

    module InstanceMethods
      def impl_loyal_core_uuid_generate(force=false)
        begin
          self.uuid = ::SecureRandom.uuid if force || self.uuid.blank?
        rescue
        end
      end
    end
  end
end

