# -*- encoding : utf-8 -*-
module LoyalAdmin
  module LoyalCore
    module Skin
      class FoldersController < ::LoyalAdmin::ApplicationController
        def index

        end

        def show
          @loyal_core_skin_folder = ::LoyalCore::Skin::Folder.find params[:id]

          @loyal_core_skin_recipes = @loyal_core_skin_folder.recipes.page(params[:page])
        end

        def new
          @loyal_core_skin_folder = ::LoyalCore::Skin::Folder.new
        end

        def create
          @loyal_core_skin_folder = ::LoyalCore::Skin::Folder.new(params[:loyal_core_skin_folder])

          @loyal_core_skin_folder.created_by = current_user.id
          @loyal_core_skin_folder.created_ip = request.remote_ip

          if @loyal_core_skin_folder.save
            redirect_to loyal_admin_app.loyal_core_skin_folder_url(:id => @loyal_core_skin_folder.id)
          else
            render :new
          end
        end

        def edit
          @loyal_core_skin_folder = ::LoyalCore::Skin::Folder.find params[:id]
        end

        def update
          @loyal_core_skin_folder = ::LoyalCore::Skin::Folder.find params[:id]

          if @loyal_core_skin_folder.update_attributes(params[:loyal_core_skin_folder])
            redirect_to loyal_admin_app.loyal_core_skin_folder_url(:id => @loyal_core_skin_folder.id)
          else
            render :edit
          end
        end

        def destroy
          @loyal_core_skin_folder = ::LoyalCore::Skin::Folder.find params[:id]

          @loyal_core_skin_folder.destroy

          redirect_to params[:return_to] || loyal_admin_app.loyal_core_skin_folders_url
        end

      end
    end
  end
end
