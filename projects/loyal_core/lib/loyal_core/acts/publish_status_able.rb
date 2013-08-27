# -*- encoding : utf-8 -*-
module LoyalCore
  # 发布状态相关
  module ActsAsPublishStatusAble
    def self.included base
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      def loyal_core_acts_as_publish_status_able *args
        _config = ::LoyalCore::ConfigUtil.new(
          {:key => 'init',        :value => 0,      :desc => '初始'},
          {:key => 'published',   :value => 2**1,   :desc => '已发布'},
          {:key => 'blocked',    :value => 2**2,   :desc => '已屏蔽'}
        )

        define_singleton_method :publish_status_config do
          _config
        end

        _config.pure_keys.each do |key, config|
          define_method :"publish_status_#{key}?" do
            self.publish_status_key == key
          end
        end

        scope :of_publish_status, ->(status_name) do
          if status_name
            status_name = status_name.to_s unless status_name.is_a?(String)
            config = _config.at(status_name)
            status = config.nil? ? nil : config.value

            where(:publish_status => status)
          end
        end

        scope :published, -> do
          of_publish_status('published')
        end

        include InstanceMethods
      end

      module InstanceMethods

        def publish_status_config
          self.class.publish_status_config.item(self.publish_status)
        end

        def publish_status_key
          self.publish_status_config.key if self.publish_status_config
        end

        def publish_status_name
          self.publish_status_key
        end

        def publish_status_name= name
          config = self.class.publish_status_config.at(name)

          if config
            self.publish_status = config.value
          end
        end

        def publish_status_desc
          self.publish_status_config.desc if self.publish_status_config
        end

      end
    end
  end
end
