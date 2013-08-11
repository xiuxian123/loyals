# -*- encoding : utf-8 -*-
module LoyalSpider
  module EntityAble
    # 有返回信息的
    def self.included base
      base.class_eval do
        attr_accessor :title           # 标题
        attr_accessor :url             # 标题
        attr_accessor :content         # 正文
        attr_accessor :tags            # 标签
        attr_accessor :tags_text       # 标签
        attr_accessor :up_rating       # 好评数
        attr_accessor :down_rating     # 差评数目
        attr_accessor :comments_count  # 评论数目
        attr_accessor :authors         # 抓取的作者信息
        attr_accessor :authors_text    # 抓取的作者信息
        attr_accessor :publish_time    # 发布时间
        attr_accessor :errors          # 错误

        include InstanceMethods
      end
    end

    module InstanceMethods
      def initialize attrs={}
        attrs.each do |key, value|
          self.send(:"#{key}=", value)
        end

        self.errors = {}
      end

      def valid?
        self.valid!
        self.errors.empty?
      end

      def valid!
        unless self.content.to_s.strip.size > 0
          add_error :content, '不能为空'
        end

        unless self.url.to_s.strip.size > 0
          add_error :url, '不能为空'
        end
      end

      private

      def add_error field, message
        (self.errors[field] ||= []) << message
      end
      
    end

  end
end
