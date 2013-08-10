# -*- encoding : utf-8 -*-
## -*- encoding : utf-8 -*-
module LoyalSpider
  module EntityListerAble
    # 有返回信息的
    def self.included base
      base.class_eval do
        attr_writer :current_page        # current_page

        include ::LoyalSpider::FetchAble
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

        self.config_loyal_spider_default_fetch_options(
          self.entity_lister_options.delete(:fetch_options) || {}
        )
      end

      def paged_fetch page, options={}, &block
        lister = self.new
        lister.current_page = page
        lister.fetch options, &block
      end

      def entity_lister_options
        @entity_lister_options ||= {}
      end

      # 按页抓取
      def paged_fetch page, options={}, &block
        self.new.paged_fetch page, options, &block
      end
    end

    module InstanceMethods
      def paged_fetch page, options={}, &block
        self.current_page = page
        self.fetch options, &block
      end

      def url_format
        self.class.entity_lister_options[:url_format]
      end

      def url_format_first
        self.class.entity_lister_options[:url_format_first]
      end

      def url_format_options
        self.class.entity_lister_options[:url_format_options]
      end

      def _before_fetch options={}
        @entities = []
      end

      def _after_fetch_success result
        result.entities = self.entities
      end

      def entities
        @entities ||= []
      end

      # TODO
      def entity_clazz
        self.class.entity_lister_options[:entity_clazz]
      end

      def add_entity attrs={}
        self.entities << self.entity_clazz.new(attrs) if self.entity_clazz
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
