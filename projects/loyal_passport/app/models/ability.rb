# -*- encoding : utf-8 -*-
class Ability
  include ::CanCan::Ability

  def initialize(current_user)
    # if user.roles?(:admin)
    #   can :manage, :all
    # end

    current_user ||= ::User.new # guest user (not logged in)

    # 如果用户是超级管理员
    if current_user && current_user.super_admin?
      can :manage, :all
    end

    # 执行
    LoyalPassport.config.cancan_abilities.each do |ability|
      if ability.is_a?(String)
        ability.constantize.new self, current_user
      end
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
