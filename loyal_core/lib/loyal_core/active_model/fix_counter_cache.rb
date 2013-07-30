# -*- encoding : utf-8 -*-
module LoyalCore
  module ActiveModel
    module FixCounterCache
      def self.included base
        base.class_eval do
          extend ClassMethods
        end
      end

      module ClassMethods
        #
        # usage:
        #   self.loyal_core_fix_counter_cache :folder_id => {
        #     :counter => :articles_count,
        #     :class   => ::Ruby800::Juice::Folder
        #   }
        #
        def loyal_core_fix_counter_cache *args
          options = args.extract_options!

          options.each do |key, opts|
            before_save do |r|
              _id = key
              _counter = opts[:counter]
              _class   = opts[:class]

              if !(r.new_record?) && r.send(:"#{_id}_changed?")
                _class.decrement_counter(:"#{_counter}", r.send(:"#{_id}_was"))
                _class.increment_counter(:"#{_counter}", r.send(:"#{_id}"))
              end
            end
          end
        end
      end
    end
  end
end

