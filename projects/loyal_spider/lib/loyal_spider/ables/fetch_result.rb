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

    def initialize attrs={}
      attrs.each do |key, value|
        self.send(:"#{key}=", value)
      end
    end

    def response_html
      @response_html ||= Nokogiri::HTML.parse(self.response)
    end

  end
end
