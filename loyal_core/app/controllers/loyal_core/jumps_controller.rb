# -*- encoding : utf-8 -*-
module LoyalCore
  class JumpsController < ApplicationController
    # TODO: 增加跳转页面的处理
    # FIXME: 跳转页面不合理
    def show
      render 'loyal_core/jumps/show', :layout => nil
    end
  end
end
