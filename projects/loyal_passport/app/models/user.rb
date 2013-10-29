# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  include ::Concerns::LoyalPassport::HomeworksAble

  PERMALINK_REGEXP = /\A[a-z][a-z0-9_\-]*\z/.freeze

  USER_REGISTER_WAY_STATUSES = {
    'email' => { :value => 0, :name => '邮箱' },
    'oauth' => { :value => 1, :name => '第三方' }
  }.freeze

  USER_REGISTER_WAY_STATUSE_MAP = USER_REGISTER_WAY_STATUSES.inject({}) do |result, pair|
    key, config = pair

    result[config[:value]] = config.merge(:key => key)

    result
  end.freeze

  # attr_accessible :title, :body
  attr_accessible :nick_name, :true_name, :role_ids, :permalink, :avatar, :password, :password_confirmation

  # 验证码相关
  self.apply_simple_captcha :message => I18n.t('activerecord.errors.models.user.attributes.captcha.message')

  ######## 第三方登录 以及 绑定相关 #################################
  has_many :oauth_binds,       :class_name => "LoyalPassport::OauthBind"
  has_many :oauth_bind_infos,  :class_name => "LoyalPassport::OauthInfo",
    :through => :oauth_binds,  :source => :oauth_info

  has_many :oauth_logins,      :class_name => "LoyalPassport::OauthLogin"
  has_many :oauth_login_infos, :class_name => "LoyalPassport::OauthInfo",
    :through => :oauth_logins, :source => :oauth_info
  ###################################################################

  belongs_to :main_oauth_login_info, :class_name => "LoyalPassport::OauthInfo"

  # 缓存
  self.acts_as_tiny_cached

  # 软删除
  self.acts_as_paranoid
  self.validates_as_paranoid
  self.validates_uniqueness_of_without_deleted :nick_name, :allow_blank => true

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

  validates :nick_name, :length => {:minimum => 2, :maximum => 12}, :allow_blank => true
  validates_format_of :permalink, :with => PERMALINK_REGEXP

  # 岗位分配 ##################
  has_many :assignments, class_name: 'LoyalPassport::Assignment',
    foreign_key: :user_id

  #  角色    ##################
  has_many :roles, class_name: 'LoyalPassport::Role',
    through: :assignments

  has_many :homeworks, :class_name => 'LoyalPassport::Homework',
    :through => :roles

  # 去除空格
  self.strip_whitespace_before_validation :email, :nick_name, :true_name,
    :mobile_number

  # 头像
  self.loyal_core_acts_as_has_avatar :avatar

  def permalink?
    !!PERMALINK_REGEXP.match(self.permalink)
  end

  def self.user_from_oauth_info oauth_info
    return if oauth_info.nil?

    self.transaction do
      user = oauth_info.login_user  # 登录的用户

      # 当前信息没有对应的用户
      if user.nil?
        user = self.new

        # TODO
        user.register_way = 'oauth'

        user.main_oauth_login_info = oauth_info

        user.save!

        oauth_login = ::LoyalPassport::OauthLogin.new

        oauth_login.user_id       = user.id
        oauth_login.oauth_info_id = oauth_info.id

        oauth_login.save!
      end

      user.save!

      user
    end
  end

  # 显示名称
  def display_name
    if self.nick_name?
      "#{self.nick_name}"
    elsif self.main_oauth_login_info
      "#{self.main_oauth_login_info.nick_name}"
    end
  end

  def register_way= way
    way_config = USER_REGISTER_WAY_STATUSES[way]

    if way_config
      self.register_way_value = way_config[:value]
    end
  end

  def register_way
    USER_REGISTER_WAY_STATUSE_MAP[self.register_way_value] || {}
  end

  # 注册来源是第三方
  def register_way_oauth?
    self.register_way[:key] == 'oauth'
  end

  # 需要校验邮箱
  def email_required?
    !self.register_way_oauth?
  end

  # 需要密码的
  def password_required?
    !self.register_way_oauth?
  end

  # 有第三方登录的
  def main_oauth_login_info?
    !!self.main_oauth_login_info
  end

  # 有邮箱的
  def email?
    self.email.present?
  end

  # 经过了oauth认证
  def oauth_login_confirmed?
    self.main_oauth_login_info?
  end

  # 是否验证过了
  #   - 如果 已经第三方登录了，则可以认为已经验证过了
  def confirmed?
    self.oauth_login_confirmed? || self.email_confirmed?
  end

  # 有密码的
  def password?
    self.encrypted_password.present?
  end

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
    self.id == 1
  end

  def not_super_admin?
    !super_admin?
  end

  extend ::LoyalCore::Memoist

  memoize :not_super_admin?, :super_admin?, :display_name

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

  # 需要验证邮箱
  def email_confirmation_required?
    !self.confirmed?
  end

end
