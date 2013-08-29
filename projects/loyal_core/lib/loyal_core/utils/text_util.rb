# -*- encoding : utf-8 -*-
module LoyalCore
  class TextUtil
    class << self
      def markdown(text)
        # options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]

        options = [:hard_wrap, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
        self.syntax_highlighter(::RedcarpetCompat.new(text, *options).to_html).html_safe
      end

      def syntax_highlighter(html)
        doc = ::Nokogiri::HTML(html)

        doc.search("//pre").each do |pre|
          lang = pre.attr('lang')

          if lang
            _lang_class = pre.attr('class').to_s.split(' ').select {|_itm| _itm.include?('lang-') }.first

            if _lang_class
              lang = _lang_class.gsub('lang-', '')
            end
          end

          # debugger
          if pre_code=pre.css('code')
            lang = pre_code.attr('class').to_s
          end

          unless lang
            lang = :text
          end

          text = pre.text.rstrip

          begin
            pre.replace ::CodeRay.scan(text, lang).div.to_s
          rescue Exception => error
            puts "#{__FILE__} syntax_highlighter error: \ntext => #{text} \nlang => #{lang}\n origin error:#{error}"
          end
        end

        doc.css('body').inner_html.to_s
      end
    end
  end
end

