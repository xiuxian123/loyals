# -*- encoding : utf-8 -*-
module LoyalCore
  module ActsAsTree
    def self.included base
      base.class_eval do
        extend  ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods
      def loyal_core_acts_as_tree options={}
        attr_accessible :parent_id

        acts_as_nested_set  options.reverse_merge(
          :parent_column => 'parent_id',
          :left_column   => 'left_id',
          :right_column  => 'right_id',
          :depth_column  => 'depth',
          :dependent     => :destroy, # or :destroy
          :polymorphic   => false,
          :counter_cache => 'children_count'
        )

        scope :filter_by_root, -> do
          where :parent_id => nil
        end

        include InstanceMethods
        extend ExtendsMethods
      end
    end

    module InstanceMethods
      def children?
        self.children_count > 0
      end

      # 祖先
      def tree_ancestor_ids
        self.ancestors.map(&:id).uniq.sort
      end

      def tree_self_and_ancestor_ids
        self.self_and_ancestors.map(&:id).uniq.sort
      end

      # 同一个父母的孩子
      def tree_sibling_ids
        self.siblings.map(&:id).uniq.sort
      end

      def tree_self_and_siblings_ids
        self.self_and_siblings_ids.map(&:id).uniq.sort
      end

      # 子孙后代
      def tree_descendant_ids
        self.descendants.map(&:id).uniq.sort
      end

      # 子孙后代 包括自己
      def tree_self_and_descendant_ids
        self.self_and_descendants.map(&:id).uniq.sort
      end
    end

    module ExtendsMethods
      def nested_set_options(class_or_item=nil, mover = nil)
        class_or_item ||= self

        if class_or_item.is_a? Array
          items = class_or_item.reject { |e| !e.root? }
        else
          class_or_item = class_or_item.roots if class_or_item.respond_to?(:scoped)
          items = Array(class_or_item)
        end

        result = []

        items.each do |root|
          result += root.class.associate_parents(root.self_and_descendants).map do |i|
            if mover.nil? || mover.new_record? || mover.move_possible?(i)
              [yield(i), i.id]
            end
          end.compact
        end

        result
      end

      def nested_set_select_options(class_or_item=nil, mover=nil, options={})
        result = []

        result << ['- - - -', nil] if options[:include_blank]

        result += nested_set_options(class_or_item, mover) do |item|
          "#{'- ' * item.level}#{item.name}"
        end
      end
    end

  end
end
