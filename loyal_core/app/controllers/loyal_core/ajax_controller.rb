# -*- encoding : utf-8 -*-
module LoyalCore
  # 处理所有ajax请求
  class AjaxController < ::LoyalCore::ApplicationController
    before_filter :require_request_xhr!

    protected

    # 需要是ajax 请求
    def require_request_xhr!

    end
  end
end
