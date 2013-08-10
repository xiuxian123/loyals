# -*- encoding : utf-8 -*-
## -*- encoding : utf-8 -*-
module LoyalSpider
  module EntityListerAble
    # 有返回信息的
    def self.included base
      base.class_eval do
        attr_writer :current_page        # current_page

        include InstanceMethods
        extend  ClassMethods
      end
    end

    module ClassMethods
      # options:
      #   - url_format
      #   - url_format_first
      #   - url_format_options
      def config_loyal_spider_entity_lister options={}
        @entity_lister_options ||= options
      end

      def entity_lister_options
        @entity_lister_options ||= {}
      end
    end

    module InstanceMethods
      def url_format
        self.class.entity_lister_options[:url_format]
      end

      def url_format_first
        self.class.entity_lister_options[:url_format_first]
      end

      def url_format_options
        self.class.entity_lister_options[:url_format_options]
      end

      def entities
        @entities ||= []
      end

      def current_page
        @current_page ||= 1
      end

      def first_page?
        self.current_page < 2
      end

      def fetch_url
        return @fetch_url if defined?(@fetch_url)

        _url_format = self.first_page? ? self.url_format_first : self.url_format

        @fetch_url ||= sprintf(
          _url_format, (
            self.url_format_options || {}
          ).merge(
            :page => self.current_page
          )
        )
      end
    end

  end
end
