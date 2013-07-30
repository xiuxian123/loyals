# -*- encoding : utf-8 -*-
module LoyalCore
  # 大字段分离
  module ActsAsContentDepartAble
    def self.included base
      base.class_eval do
        extend  ClassMethods
      end
    end

    LOYAL_CORE_OUTLINE_MAX_LENGTH = 255.freeze

    module ClassMethods
      #
      # options:
      #   - worker_class
      #
      def loyal_core_acts_as_content_owner *args
        options =  args.extract_options!

        self.attr_accessible :content, :outline, :content_code, :content_mode, :content_mode_was_cache

        worker_class = options[:worker_class]

        belongs_to :content_worker, :class_name => "#{worker_class.to_s}", :dependent => :destroy,
          :foreign_key => options[:foreign_key]

        before_validation do |r|
          # FIXME: 大纲该如何生成呢？

          r.outline = ::Sanitize.clean(
            r.content_text,
            ::LoyalCore.config.sanitize_config[:text]
          ).to_s[0...LOYAL_CORE_OUTLINE_MAX_LENGTH]
        end

        # validates_length_of :outline, :maximum => LOYAL_CORE_OUTLINE_MAX_LENGTH

        after_save do |r|
          r.lastest_content_worker.target = r
          r.lastest_content_worker.save!
        end

        define_method :lastest_content_worker do
          self.content_worker ||= worker_class.new
        end

        ###############################################
        define_singleton_method :content_mode_config do
          worker_class.content_mode_config
        end

        delegate :words_amount_more?, :content=, :content, :content_text, :words_amount,
          :content_code=, :content_code,
          :content_mode, :content_mode=,

          :content_mode_was_cache, :content_mode_was_cache=,
          :content_mode_was_cache_changed?,
          :content_mode_was_cache_reset!,

          :content_mode_name=, :content_mode_name,
          :to => :lastest_content_worker

        validate do |r|
          # 如果正文的格式改变了，需要提示
          if r.content_mode_was_cache_changed?
            r.errors.add(:content_mode, '变化了, 请检查正文格式') 
            r.content_mode_was_cache_reset!
          end
        end

        include ContentOwnerInstanceMethods
      end

      module ContentOwnerInstanceMethods

      end

      #
      # options:
      #   - owner_class
      #
      def loyal_core_acts_as_conent_worker *args
        options =  args.extract_options!

        belongs_to :target, :polymorphic => true

        before_validation do |r|
          r.words_amount = r.content_text.size
        end

        include ContentWorkerMethods
      end

      module ContentWorkerMethods
        def words_amount_more? count=LOYAL_CORE_OUTLINE_MAX_LENGTH
          self.words_amount > count
        end
      end
    end
  end
end
