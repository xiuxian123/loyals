# -*- encoding : utf-8 -*-
module LoyalCore
  module ActsAsHasPermalink
    PERMALINK_REGEXP  = /^[A-Za-z0-9\_]+$/.freeze

    def self.included base
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      def loyal_core_acts_as_has_permalink *args
        options = args.extract_options!
        field_name = args.first || :permalink

        include WithSpaceMethods

        if options[:with_space]
          validates_format_of  field_name, :with => PERMALINK_REGEXP, :unless => :space_root?, :multiline => true
          validates_presence_of  field_name, :unless => :space_root?

          # space 格式要求正确
          validates_format_of :space, :with => PERMALINK_REGEXP, :multiline => true
          validates_uniqueness_of field_name, :uniqueness => {:scope => [:space]}
        else
          validates_format_of  field_name, :with => PERMALINK_REGEXP, :multiline => true
          validates_presence_of  field_name

          validates_uniqueness_of field_name
        end
      end

      module WithSpaceMethods

        def space_root?
          self.permalink.blank?
        end
      end
    end
  end
end

