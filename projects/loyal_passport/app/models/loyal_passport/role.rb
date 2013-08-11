# -*- encoding : utf-8 -*-
class LoyalPassport::Role < ActiveRecord::Base
  include ::Concerns::LoyalPassport::HomeworksAble

  # FIXME:
  attr_accessible :permalink, :name, :instroduction, :description, :user_ids

  self.acts_as_tiny_cached

  # 角色分类 ###################
  has_many :assignments, class_name: 'LoyalPassport::Assignment',
    :foreign_key => :role_id, :dependent => :destroy

  has_many :users, :class_name => 'User',
    :through => :assignments

  has_many :homeworks, :class_name => 'LoyalPassport::Homework',
    :dependent => :destroy

  self.strip_whitespace_before_validation :permalink, :name

  # 不能为空，且唯一
  validates :permalink, :presence => true, :uniqueness => true
  validates :name, :presence => true

end
