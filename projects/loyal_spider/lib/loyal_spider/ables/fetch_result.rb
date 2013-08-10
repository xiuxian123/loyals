# -*- encoding : utf-8 -*-
module LoyalSpider
  class FetchResult

    attr_accessor :response_status
    attr_accessor :response_code
    attr_accessor :response
    attr_accessor :request
    attr_accessor :response_result
    attr_accessor :fetch_options
    attr_accessor :url
    attr_accessor :exception
    attr_accessor :entities

    def initialize attrs={}
      attrs.each do |key, value|
        self.send(:"#{key}=", value)
      end
    end

    def success?
      self.response_status == :success
    end

    def fail?
      !success?
    end

    def response_html_doc
      @response_html_doc ||= Nokogiri::HTML.parse(self.response) if self.response
    end

  end
end
