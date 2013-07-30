# -*- encoding : utf-8 -*-
module LoyalCore
  # 大字段分离
  module ActsAsContentModeAble
    def self.included base
      base.class_eval do
        extend  ClassMethods
      end
    end

    LOYAL_CORE_CONTENT_MODE_CONFIGS = ::LoyalCore::ConfigUtil.new(
      { :key => :html,     :value => 0, :desc => "HTML" },
      { :key => :text,     :value => 1, :desc => "TEXT" },
      { :key => :markdown, :value => 2, :desc => "Markdown" }
    )

    module ClassMethods
      def loyal_core_acts_as_content_mode_able *args
        extend  ContentModeClassMethods
        include ContentModeInstanceMethods

        # 文字不能为空
        # validates_presence_of :content_text
      end

      module ContentModeClassMethods
        def content_mode_config
          LOYAL_CORE_CONTENT_MODE_CONFIGS
        end
      end

      module ContentModeInstanceMethods
        def content_mode_was_cache_reset!
          @content_mode_was_cache = self.content_mode
        end

        # FIXME
        def content_mode_was_cache
          (
            @content_mode_was_cache ||= self.content_mode
          ).to_i
        end

        def content_mode_was_cache= mode
          @content_mode_was_cache = mode
        end

        def content_mode_was_cache_changed?
          self.content_mode_was_cache != self.content_mode
        end

        def content_mode_name= name
          self.content_mode = self.class.content_mode_config.at(name).value
        end

        def content_mode_name
          self.class.content_mode_config.item(self.content_mode).key
        end

        def content
          case self.content_mode_name
          when :html
            ::LoyalCore::TextUtil.syntax_highlighter(
              ::Sanitize.clean(self.content_code, ::LoyalCore.config.sanitize_config[:relaxed])
            )
          when :markdown
            # TODO: markdown
            ::LoyalCore::TextUtil.markdown(self.content_code)
          when :text
            self.content_text
          end
        end

        def content= content
          self.content_code = content
        end

        def content_text
          ::Sanitize.clean(self.content_code, ::LoyalCore.config.sanitize_config[:text])  || 0
        end

        extend ::LoyalCore::Memoist

        memoize :content_text, :content
      end
    end
  end
end
