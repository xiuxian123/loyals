# -*- encoding : utf-8 -*-
module LoyalCore
  module ActsAsBitAble
    def self.included(base)
      base.class_eval do
        extend  ClassMethods
      end
    end

    module ClassMethods
      def loyal_core_acts_as_bit_able_util_get_values *names, config
        values = []

        ::LoyalCore::ArrayUtil.init(names).each do |_name|
          _config = config.at _name

          if _config && (_val = _config.value)
            (1.upto(2 ** config.max_value)).each do |__val|
              if __val & _val == _val
                values << __val
              end
            end
          end
        end

        values.uniq.sort
      end

      #
      # field_name
      # options:
      #   - config:
      #
      # 定义了：
      #   - filter_by_bit_color *names
      #   - color_bit_set  name
      #   - color_bit_unset  name
      #   - color_bit?  name
      #   - color_bit_reset!
      #   - color_bit_list
      #   - color_bit_list= *names
      #
      def loyal_core_acts_as_bit_able *args
        options = args.extract_options!

        field_name = args.first

        if field_name.nil?
          raise "#{self}.loyal_core_acts_as_bit_able field_name can not be nil"
        end

        config = options[:config] || ::LoyalCore::ConfigUtil.new

        scope :"filter_by_bit_#{field_name}", ->(*names_args) do
          _values = loyal_core_acts_as_bit_able_util_get_values *names_args, config

          if _values.any?
            where :"#{field_name}" => _values
          end
        end

        # attr_accessor :"#{field_name}_values"

        self.class.send :define_method, :"#{field_name}_bit_config" do
          config
        end

        # level_bit_set name
        # level_bit? name
        # level_bit_unset name

        define_method :"#{field_name}_bit_set" do |name, saved=false|
          _config = config.at name

          result = self.send("#{field_name}=", (self.send(field_name) | _config.value))
          self.save if saved
          result
        end

        define_method :"#{field_name}_bit?" do |name, saved=false|
          _config = config.at name
          value = _config.value

          result = (self.send(field_name) & value) == value
          self.save if saved
          result
        end

        define_method :"#{field_name}_bit_unset" do |name, saved=false|
          _config = config.at name
          value = _config.value

          result = if self.send("#{field_name}_bit?", name)
                     self.send("#{field_name}=", (self.send(field_name) - value))
                   else
                     self.send("#{field_name}")
                   end

          self.save if saved

          result
        end

        # 重置
        define_method :"#{field_name}_bit_reset!" do |saved=false|
          result = self.send("#{field_name}=", 0)

          self.save if saved

          result
        end

        #
        # colors_bit_list: 获取bit配置列表
        #  
        define_method :"#{field_name}_bit_list" do
          config.keys.inject([]) do |result, name|
            if config.at(name).value.to_i > 0 && self.send(:"#{field_name}_bit?", name)
              result << name
            end

            result
          end
        end

        define_method :"#{field_name}_bit_list=" do |names|
          self.send :"#{field_name}_bit_reset!", false

          names.each do |name|
            self.send :"#{field_name}_bit_set", name, false
          end

          self.send :"#{field_name}_bit_list"
        end
      end
    end
  end
end

