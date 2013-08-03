# -*- encoding : utf-8 -*-
module LoyalAdmin
  module LoyalCore
    module Skin
      class RecipesController < ::LoyalAdmin::ApplicationController
        def index
          @loyal_core_skin_recipes = ::LoyalCore::Skin::Recipe.page(params[:page])
        end

        def show
          @loyal_core_skin_recipe = ::LoyalCore::Skin::Recipe.find params[:id]
        end

        def new
          @loyal_core_skin_recipe = ::LoyalCore::Skin::Recipe.new
        end

        def create
          @loyal_core_skin_recipe = ::LoyalCore::Skin::Recipe.new(params[:loyal_core_skin_recipe])

          @loyal_core_skin_recipe.created_by = current_user.id
          @loyal_core_skin_recipe.created_ip = request.remote_ip

          if @loyal_core_skin_recipe.save
            redirect_to loyal_admin_app.loyal_core_skin_recipe_url(:id => @loyal_core_skin_recipe.id)
          else
            render :new
          end
        end

        def edit
          @loyal_core_skin_recipe = ::LoyalCore::Skin::Recipe.find params[:id]
        end

        def update
          @loyal_core_skin_recipe = ::LoyalCore::Skin::Recipe.find params[:id]

          if @loyal_core_skin_recipe.update_attributes(params[:loyal_core_skin_recipe])
            redirect_to loyal_admin_app.loyal_core_skin_recipe_url(:id => @loyal_core_skin_recipe.id)
          else
            render :edit
          end
        end

        def destroy
          @loyal_core_skin_recipe = ::LoyalCore::Skin::Recipe.find params[:id]

          @loyal_core_skin_recipe.destroy

          redirect_to params[:return_to] || loyal_admin_app.loyal_core_skin_recipes_url
        end

      end
    end
  end
end
