# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  include ::Concerns::LoyalPassport::HomeworksAble

  # PERMALINK_REGEXP  = /^[A-Za-z0-9\_]+$/.freeze
  PERMALINK_REGEXP  = /^[A-Za-z0-9]+$/.freeze

  # attr_accessible :title, :body
  attr_accessible :nick_name, :true_name, :role_ids, :permalink

  self.apply_simple_captcha :message => I18n.t('activerecord.errors.models.user.attributes.captcha.message')

  self.acts_as_tiny_cached

  # 软删除
  self.acts_as_paranoid
  self.validates_as_paranoid
  self.validates_uniqueness_of_without_deleted :nick_name
  self.loyal_core_acts_as_has_permalink :with_space => false, :paranoid => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable,
    :token_authenticatable,
    :confirmable,
    :lockable,
    :timeoutable,
    :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  validates :nick_name, :presence => true,
    :length => {:minimum => 2, :maximum => 12}

  # 岗位分配 ##################
  has_many :assignments, class_name: 'LoyalPassport::Assignment',
    foreign_key: :user_id

  has_many :roles, class_name: 'LoyalPassport::Role',
    through: :assignments

  has_many :homeworks, :class_name => 'LoyalPassport::Homework',
    :through => :roles

  # 去除空格
  self.strip_whitespace_before_validation :email, :nick_name, :true_name,
    :mobile_number, :permalink

  before_validation do
    self.permalink = self.nick_name if self.permalink.blank?
  end

  validates_format_of :permalink, :with => PERMALINK_REGEXP, :multiline => true
  validates_length_of :permalink, :minimum => 3, :maximum => 12

  # 头像
  self.loyal_core_acts_as_has_avatar :avatar

  def ability
    @ability ||= ::Ability.new(self)
  end

  # eg: some_user.can? :update, @article
  delegate :can?, :cannot?, :to => :ability

  def roles?(*args)
    options = args.extract_options!

    self.super_admin? || self.roles.exists?({:permalink => args})
  end

  def super_admin?
    ['happy'].include?(self.nick_name)
  end

  def not_super_admin?
    !super_admin?
  end

  extend ::LoyalCore::Memoist

  memoize :not_super_admin?, :super_admin?

  class << self
    # 能注销帐号吗？
    def can_cancel_account?
      false && ::LoyalPassport.config.logics[:open_account_cancel?]
    end
  end

  def can_cancel_account?
    self.class.can_cancel_account? && !(
      self.super_admin?  # 不是超级管理员
    )
  end

  protected

end
