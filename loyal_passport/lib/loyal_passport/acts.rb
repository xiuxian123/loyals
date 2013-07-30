# -*- encoding : utf-8 -*-
require "#{File.dirname(__FILE__)}/acts/acts_as_author_able"
require "#{File.dirname(__FILE__)}/acts/acts_as_locker_able"

module LoyalPassport

end

if defined?(::ActiveRecord::Base)
  ::ActiveRecord::Base.send :include, ::LoyalPassport::ActsAsAuthorAble
  ::ActiveRecord::Base.send :include, ::LoyalPassport::ActsAsLockerAble
end
