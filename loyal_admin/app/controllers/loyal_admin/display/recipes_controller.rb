# -*- encoding : utf-8 -*-
module LoyalAdmin
  class Display::RecipesController < ::LoyalAdmin::ApplicationController
    def index
      @display_recipes = ::LoyalAdmin::Display::Recipe.page(params[:page]).per(30)
    end

    def show
      @display_recipe = ::LoyalAdmin::Display::Recipe.find params[:id]
    end

    def new
      @display_recipe = ::LoyalAdmin::Display::Recipe.new
    end

    def create
      @display_recipe = ::LoyalAdmin::Display::Recipe.new(params[:display_recipe])

      if @display_recipe.save
        redirect_to loyal_admin_app.display_recipe_url(:id => @display_recipe.id)
      else
        render :new
      end
    end

    def edit
      @display_recipe = ::LoyalAdmin::Display::Recipe.find params[:id]
    end

    def update
      @display_recipe = ::LoyalAdmin::Display::Recipe.find params[:id]

      if @display_recipe.update_attributes(params[:display_recipe])
        redirect_to loyal_admin_app.display_recipe_url(:id => @display_recipe.id)
      else
        render :edit
      end
    end

    def destroy
      @display_recipe = ::LoyalAdmin::Display::Recipe.find params[:id]

      @display_recipe.destroy

      redirect_to params[:return_to] || loyal_admin_app.display_recipes_url
    end

  end
end
