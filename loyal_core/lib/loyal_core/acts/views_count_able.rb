# -*- encoding : utf-8 -*-
module LoyalCore
  module ActsAsViewsCountAble
    def self.included base
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      # 具备计数功能
      # views_count
      def loyal_core_acts_as_views_count_able *args
        options = ::LoyalCore::ArrayUtil.extract_options!(args)

        define_method :increment_views_count! do
          Rails.logger.debug " -> loyal_core_acts_as_views_count_able: #{self.id} increment_views_count!"
          self.increment(:views_count)

          # 刷新更新时间
          self.refresh_tiny_cache_updated_at
          self.write_tiny_cache # 写入缓存

          # 频率间隔, 默认为10次
          if self.views_count % (options[:interval] || 10).to_i == 0
            self.class.update_all({:views_count => self.views_count}, :id => self.id)
          end
        end
      end
    end
  end
end

