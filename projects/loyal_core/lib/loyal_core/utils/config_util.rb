# -*- encoding : utf-8 -*-
module LoyalCore
  class ConfigUtil
    attr_reader :config_values_map, :select_options,
      :default_item, :config_keys_map, :pure_keys, :pure_values

    # config*
    #   [
    #     {
    #       :key => :name, :value => 1, :desc => 'Hello World'
    #     },
    #     {
    #       :key => :age, :value => 2, :desc => 'Good'
    #     },
    #     {
    #       :desc => '地址',
    #       :group => [
    #
    #       ]
    #     }
    #   ]
    def initialize *args
      # options = args.extract_options!

      @config_values_map = {}
      @config_keys_map   = {}
      @select_options = impl_collect_select_options args
      @default_item = nil

      impl_collect_item args

      @pure_values = @config_values_map.keys.freeze
      @pure_keys   = @config_keys_map.keys.freeze

      @config_values_map.freeze
      @config_keys_map.freeze
      @select_options.freeze
      @default_item.freeze

      self.freeze
    end

    def at(key)
      @config_keys_map[key]
    end

    def item(value)
      @config_values_map[value]
    end

    def to_select_options
      @select_options.dup
    end

    private

    def impl_collect_select_options item
      if item.is_a?(Hash)
        if item[:group].is_a?(Array)
          [item[:desc]] + [
            impl_collect_select_options(item[:group])
          ]
        elsif item.key?(:key) && item.key?(:value)
          [item[:desc], item[:value]]
        end
      elsif item.is_a?(Array)
        item.map do |itm|
          impl_collect_select_options itm
        end
      end
    end

    def impl_collect_item item
      if item.is_a? Hash
        if item[:group].is_a?(Array)
          impl_collect_item item[:group]
        else
          if item.key?(:key) && item.key?(:value)
            util_item = ConfigUtilItem.new item
            @config_values_map[item[:value]] = util_item
            @config_keys_map[item[:key]]   = util_item

            if item[:default]
              @default_item = util_item
            end
          end
        end
      elsif item.is_a? Array
        item.each do |itm|
          impl_collect_item itm
        end
      end
    end
  end

  class ConfigUtilItem
    def initialize(item={})
      @item = item || {}
    end

    def [] key
      @item[key]
    end

    def method_missing(method_name, *args, &block)
      @item[method_name.to_sym]
    end

  end
end

