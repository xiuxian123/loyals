# -*- encoding : utf-8 -*-
module LoyalAdmin
  class ApplicationController < ActionController::Base
    before_filter :loyal_authenticate_admin!

    layout 'loyal_admin/application'
  end
end

