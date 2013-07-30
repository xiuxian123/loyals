# -*- encoding : utf-8 -*-
module LoyalPassport
  class Homework < ActiveRecord::Base
    attr_accessible :name, :job_name

    belongs_to :role, :class_name => "LoyalPassport::Role"
    validates_uniqueness_of :role_id, :scope => [:name, :job_name]
    validates_presence_of :role_id, :name, :job_name

    self.acts_as_tiny_cached

    validate do |r|
      r.errors.add :job_name, '没有配置' unless r.authoritie_job_config?
    end

    def self.authoritie_configs
      ::LoyalPassport.config.authoritie_configs
    end

    def authoritie_job_config
      @authoritie_job_config ||= (
        config = (
          (
            self.class.authoritie_configs[self.name] || {}
          )[:jobs] || {}
        )[self.job_name]

        case config
        when Hash
          config
        when String
          {:desc => config}
        end
      )
    end

    def authoritie_job_config?
      self.authoritie_job_config.is_a?(Hash)
    end

  end
end
