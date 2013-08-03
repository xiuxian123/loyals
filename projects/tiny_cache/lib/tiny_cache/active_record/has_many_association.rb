# -*- encoding : utf-8 -*-
module TinyCache
  module ActiveRecord
    module Associations
      module HasManyAssociation
        extend ::ActiveSupport::Concern

        # FIXME 尚未实现！！

        included do
          class_eval do
            alias_method_chain :find_target, :tiny_cache
          end
        end

        def association_class
          @reflection.klass
        end

        # 在缓存中取的数据
        def find_target_with_tiny_cache
          return find_target_without_tiny_cache unless association_class.tiny_cache_enabled?
          records =
            if options[:finder_sql]
              reflection.klass.find_by_sql(custom_finder_sql)
            else
              scoped.all
            end

          records = options[:uniq] ? uniq(records) : records
          records.each { |record| set_inverse_instance(record) }
          records
        end
      end
    end
  end
end
