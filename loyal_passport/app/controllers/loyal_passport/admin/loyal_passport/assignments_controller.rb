# -*- encoding : utf-8 -*-
module LoyalPassport
  class Admin::LoyalPassport::AssignmentsController < ApplicationController
    def destroy
      @loyal_passport_assignment = ::LoyalPassport::Assignment.find params[:id]
      @loyal_passport_assignment.destroy

      redirect_to params[:return_to]
    end
  end
end
