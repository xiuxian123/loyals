# -*- encoding : utf-8 -*-
module LoyalPassport::Controllers
  class CustomFailureApp < ::Devise::FailureApp

    def respond
      if http_auth?
        http_auth
      elsif warden_options[:recall]
        recall
      else
        redirect
      end
    end

    def http_auth
      self.status = 401
      self.headers["WWW-Authenticate"] = %(Basic realm=#{Devise.http_authentication_realm.inspect}) if http_auth_header?
      self.content_type = request.format.to_s
      self.response_body = http_auth_body
    end

    def self.call(env)
      @respond ||= action(:respond)
      @respond.(env)
    end

    def recall
      env["PATH_INFO"]  = attempted_url
      flash.now[:alert] = i18n_message(:invalid)
      self.response = recall_app(warden_options[:recall]).call(env)
    end

    def redirect
      # store_location!
      options = {}

      _redirect_url = redirect_url

      if (return_to = failures_url_return_to) && (return_to != _redirect_url)
        options[:return_to] = return_to
      end

      if flash[:timedout] && flash[:alert]
        flash.keep(:timedout)
        flash.keep(:alert)
      else
        flash[:alert] = i18n_message
      end

      if options.any?
        redirect_to "#{_redirect_url}?#{options.to_query}"
      else
        redirect_to _redirect_url
      end
    end

    protected

    def i18n_message(default = nil)
      message = warden_message || default || :unauthenticated

      if message.is_a?(Symbol)
        I18n.t(:"#{scope}.#{message}", :resource_name => scope,
               :scope => "devise.failure", :default => [message])
      else
        message.to_s
      end
    end

    #### 登录失败后要跳转的页面 ##################
    def redirect_url
      if warden_message == :timeout
        flash[:timedout] = true
        attempted_url || scope_url
      else
        scope_url
      end
    end

    ### 这里写得倒是很妙 #################
    def context_router
      send(Devise.available_router_name)
    end

    def scope_url options={}
      opts  = {
        # :host => ::LoyalPassport.config.host
        :subdomain => ::LoyalPassport.config.subdomain
      }.merge(
        options
      )

      route = :"new_#{scope}_session_url"
      opts[:format] = request_format unless skip_format?

      config = Rails.application.config
      opts[:script_name] = (config.relative_url_root if config.respond_to?(:relative_url_root))

      context = context_router

      if context.respond_to?(route)
        context.send(route, opts)
      elsif respond_to?(:root_url)
        root_url(opts)
      else
        "/"
      end
    end

#    def scope_path
#      opts  = {}
#      route = :"new_#{scope}_session_path"
#      opts[:format] = request_format unless skip_format?
#
#      opts[:script_name] = (config.relative_url_root if config.respond_to?(:relative_url_root))
#
#      context = send(Devise.available_router_name)
#
#      if context.respond_to?(route)
#        context.send(route, opts)
#      elsif respond_to?(:root_path)
#        root_path(opts)
#      else
#        "/"
#      end
#    end

    def skip_format?
      %w(html */*).include? request_format.to_s
    end

    # Choose whether we should respond in a http authentication fashion,
    # including 401 and optional headers.
    #
    # This method allows the user to explicitly disable http authentication
    # on ajax requests in case they want to redirect on failures instead of
    # handling the errors on their own. This is useful in case your ajax API
    # is the same as your public API and uses a format like JSON (so you
    # cannot mark JSON as a navigational format).
    def http_auth?
      if request.xhr?
        Devise.http_authenticatable_on_xhr
      else
        !(request_format && is_navigational_format?)
      end
    end

    # It does not make sense to send authenticate headers in ajax requests
    # or if the user disabled them.
    def http_auth_header?
      Devise.mappings[scope].to.http_authenticatable && !request.xhr?
    end

    def http_auth_body
      return i18n_message unless request_format
      method = "to_#{request_format}"

      if method == "to_xml"
        {
          :error  => i18n_message,
          :code   => :unauthorized,
          :status => self.status,
          :return_to => request.params[:return_to].to_s
        }.to_xml(:root => "response")
      elsif {}.respond_to?(method)
        {
          :response => {
            :error  => i18n_message,
            :code   => :unauthorized,
            :status => self.status,
            :return_to => request.params[:return_to].to_s
          }
        }.send(method)
      else
        i18n_message
      end
    end

    def recall_app(app)
      controller, action = app.split("#")
      controller_name  = ActiveSupport::Inflector.camelize(controller)
      controller_klass = ActiveSupport::Inflector.constantize("#{controller_name}Controller")
      controller_klass.action(action)
    end

    def warden
      env['warden']
    end

    ####### Warden::Manager.before_failure config ######################
    def warden_options
      (env['warden.options'] ||= {})
    end

    def warden_message
      @message ||= warden.message || warden_options[:message]
    end

    def scope
      @scope ||= warden_options[:scope] || Devise.default_scope
    end

    def attempted_url
      warden_options[:attempted_url]
    end

    def attempted_path
      warden_options[:attempted_path]
    end

    # Stores requested uri to redirect the user after signing in. We cannot use
    # scoped session provided by warden here, since the user is not authenticated
    # yet, but we still need to store the uri based on scope, so different scopes
    # would never use the same uri to redirect.
    def store_location!
      session["#{scope}_#{:return_to}"] = attempted_url if request.get? && !http_auth?
    end

    def failures_url_return_to
      #  get 请求 and 不是 http_auth
      if request.get? && !http_auth?
        attempted_url
      else request.params[:return_to].present?
        request.params[:return_to]
      end
    end

    def is_navigational_format?
      Devise.navigational_formats.include?(request_format)
    end

    def request_format
      @request_format ||= request.format.try(:ref)
    end

  end
end

