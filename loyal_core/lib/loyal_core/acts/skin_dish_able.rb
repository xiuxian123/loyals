# -*- encoding : utf-8 -*-
module LoyalCore
  module ActsAsSkinDishAble
    def self.included base
      base.class_eval do
        extend  ExtendMethods
      end
    end

    module ExtendMethods
      def loyal_core_acts_as_skin_dish_able *args
        options = args.extract_options!

        has_one :skin_dish, :class_name => '::LoyalCore::Skin::Dish', :as => :target
        has_one :skin_recipe, :class_name => '::LoyalCore::Skin::Recipe',
          :through => :skin_dish, :source => :recipe

        attr_accessible :skin_recipe_id

        define_method :skin_recipe_id do
          @skin_recipe_id ||= self.skin_recipe.try(:id)
        end

        define_method :skin_recipe_id= do |recipe_id|
          @skin_recipe_id ||= recipe_id  
        end

        before_validation do |r|
          r.skin_recipe = ::LoyalCore::Skin::Recipe.find_by_id(r.skin_recipe_id)
        end

        define_method :skin_recipe_html do |context|
          html = ''

          if self.skin_recipe
            if self.skin_recipe.assets_path.present?
              html << context.stylesheet_link_tag(self.skin_recipe.assets_path)
            end

            if self.skin_recipe.stylesheet_text.present?
              html += <<-HTML
                <style type='text/css'>
              #{self.skin_recipe.stylesheet_text}
                </style>
              HTML
            end
          end

          html
        end

      end
    end
  end
end

