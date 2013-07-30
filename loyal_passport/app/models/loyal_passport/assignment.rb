# -*- encoding : utf-8 -*-
class LoyalPassport::Assignment < ActiveRecord::Base
  attr_accessible :user_id, :role_id

  belongs_to :role, class_name: 'LoyalPassport::Role'
  belongs_to :user, class_name: 'User'

  validates :role, :user, :presence => true
  validates_uniqueness_of :user_id, :scope => [:role_id]
end
