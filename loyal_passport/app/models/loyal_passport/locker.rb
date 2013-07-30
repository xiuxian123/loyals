# -*- encoding : utf-8 -*-
module LoyalPassport
  class Locker < ActiveRecord::Base
    # attr_accessible :title, :body

    LOCKER_ABLE_LEVEL_CONFIG = ::LoyalCore::ConfigUtil.new(
      { :key => :nothing, :value => 0,    :desc => '不能操作' },
      { :key => :read,    :value => 2**0, :desc => '读' },
      { :key => :write,   :value => 2**1, :desc => '写' },
      { :key => :delete,  :value => 2**2, :desc => '删' }
    )

    self.loyal_core_acts_as_bit_able :level, :config => LOCKER_ABLE_LEVEL_CONFIG

  end
end
