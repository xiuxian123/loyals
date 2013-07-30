# -*- encoding : utf-8 -*-
class LoyalPassport::Ability
  def initialize ability, current_user
    #            屏蔽用户
    ability.can [:review], [::User] do |user|
      # 不是超级用户          当前用户有相应权限                        被管理的用户有相应的权限
      user.not_super_admin? && current_user.homework?(:review, :user) && user.unhomework?(:review, :user)
    end

    ability.can [:destroy, :block], [::User] do |user|
      ability.can?(:review, user)
    end

    # 能更新用户的信息
    ability.can [:update], [::User] do |user|
      (current_user.id == user.id) || ability.can?(:review, user)
    end

  end
end
