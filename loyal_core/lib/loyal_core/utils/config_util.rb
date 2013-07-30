# -*- encoding : utf-8 -*-
module LoyalCore
  class ConfigUtil
    attr_reader :config_values_map, :pure_values, :select_options,
      :default_item

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

#  module LoyalCore
#    # 配置工具类
#    class ConfigUtil < ::Hash
#      attr_reader :config_values_map, :pure_values
#  
#      # 
#      # configs:
#      #   {
#      #     :john    => { :value => 1, :desc => '约翰' },
#      #     :liming =>  { :value => 2, :desc => '黎明' },
#      #     :have => {
#      #       :book => {
#      #         :value => 3， ：desc => ''
#      #       }
#      #     }
#      #     ...
#      #   }
#      def initialize(*args)
#        configs = args.extract_options!
#        @default_key = args.first
#        @config_values_map = {}
#  
#        configs.each do |key, item|
#          self[key] = ConfigUtilItem.new(item.merge(:key => key))
#          @config_values_map[self[key].value] = self[key]
#        end
#  
#        @config_values_map.freeze
#        @pure_values = @config_values_map.keys.freeze
#  
#        @select_options = (
#          self.values.map do |item|
#            [item.desc, item.value]
#          end
#        ).freeze
#  
#        self.freeze
#      end
#  
#      def at(key)
#        self[key]
#      end
#  
#      def item(value)
#        @config_values_map[value] || ( self[@default_key] unless @default_key.nil? )
#      end
#  
#      # options:
#      #   - include_blank:
#      def select_options options={}
#        result = @select_options.dup
#  
#        if options.key?(:include_blank)
#          if options[:include_blank].is_a?(::Hash)
#            result.insert(0, [options[:include_blank][:desc] || '- - 请选择 - -', options[:include_blank][:value].to_i])
#          elsif options[:include_blank]
#            result.insert(0, ['- - 请选择 - -', 0])
#          end
#        end
#  
#        result
#      end
#    end
#  
#    class ConfigUtilItem
#      def initialize(item={})
#        @item = item || {}
#      end
#  
#      def [] key
#        @item[key]
#      end
#  
#      def method_missing(method_name, *args, &block)
#        @item[method_name.to_sym]
#      end
#    end
#  end
