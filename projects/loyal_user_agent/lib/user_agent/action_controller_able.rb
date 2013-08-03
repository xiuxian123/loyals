class UserAgent
  module ActionControllerAble
    def self.included base
      base.class_eval do
        include InstanceMethods

        helper_method :current_user_agent
      end
    end

    module InstanceMethods
      def current_user_agent
        @current_user_agent ||= ::UserAgent.new(request.user_agent)
      end
    end
  end
end
