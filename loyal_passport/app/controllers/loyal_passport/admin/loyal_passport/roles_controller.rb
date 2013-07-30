# -*- encoding : utf-8 -*-
module LoyalPassport
  class Admin::LoyalPassport::RolesController < ::LoyalAdmin::ApplicationController
    def index
      @loyal_passport_roles = ::LoyalPassport::Role.page(params[:page]).per(30)
    end

    def show
      @loyal_passport_role = ::LoyalPassport::Role.find params[:id]

      @loyal_passport_assignments = @loyal_passport_role.assignments.includes(:user)

      @users = ::User.page(params[:page]).per(50)
    end

    def new
      @loyal_passport_role = ::LoyalPassport::Role.new
    end

    def create
      params[:loyal_passport_role] ||= {}
      params[:loyal_passport_role][:user_ids] ||= []

      @loyal_passport_role = ::LoyalPassport::Role.new(params[:loyal_passport_role])

      if @loyal_passport_role.save
        redirect_to loyal_passport_app.admin_loyal_passport_role_url(:id => @loyal_passport_role.id)
      else
        render :new
      end
    end

    def edit
      @loyal_passport_role = ::LoyalPassport::Role.find params[:id]
    end

    def update 
      params[:loyal_passport_role] ||= {}
      params[:loyal_passport_role][:user_ids] ||= []

      @loyal_passport_role = ::LoyalPassport::Role.find params[:id]

      if @loyal_passport_role.update_attributes(params[:loyal_passport_role])
        redirect_to params[:return_to] || loyal_passport_app.admin_loyal_passport_role_url(:id => @loyal_passport_role.id)
      else
        render :edit
      end
    end

    def destroy
      @loyal_passport_role = ::LoyalPassport::Role.find params[:id]

      @loyal_passport_role.destroy

      redirect_to loyal_passport_app.admin_loyal_passport_roles_url

    end
  end
end
