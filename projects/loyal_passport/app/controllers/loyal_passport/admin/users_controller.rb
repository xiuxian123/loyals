# -*- encoding : utf-8 -*-
module LoyalPassport
  class Admin::UsersController < ::LoyalAdmin::ApplicationController
    def index
      @users = ::User.page(params[:page]).per(30)
    end

    def show
      @user = ::User.find params[:id]
    end

    def edit
      @user = ::User.find params[:id]

    end

    def update
      params[:user][:role_ids] ||= []
      @user = ::User.find params[:id]

      if @user.update_attributes(params[:user])
        redirect_to loyal_passport_app.admin_user_url(@user)
      else
        render :edit
      end
    end

  end
end
