require 'user_agent/action_controller_able'

class UserAgent
  attr_reader :user_agent_string

  MOBILE_USER_AGENTS = 'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
    'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
    'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
    'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
    'webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|' +
    'mobile'

  MOBILE_USER_AGENTS_REGEXP = ::Regexp.new(MOBILE_USER_AGENTS)

  def initialize(ua='')
    @user_agent_string = ua.to_s.downcase
  end

  def mobile_device?
    !!(@user_agent_string =~ MOBILE_USER_AGENTS_REGEXP)
  end

  def device?(type)
    @user_agent_string.include?(type.to_s.downcase)
  end
end

if defined? ActionController::Base
  ::ActionController::Base.send :include, ::UserAgent::ActionControllerAble
end

