# -*- encoding : utf-8 -*-
require 'digest/sha1'

module SimpleCaptcha #:nodoc
  module Utils #:nodoc
    # Execute command with params and return output if exit status equal expected_outcodes
    def self.run(cmd, params = "", expected_outcodes = 0)
      command = %Q[#{cmd} #{params}].gsub(/\s+/, " ")
      command = "#{command} 2>&1"

      unless (image_magick_path = SimpleCaptcha.image_magick_path).blank?
        command = File.join(image_magick_path, command)
      end

      output = `#{command}`

      unless [expected_outcodes].flatten.include?($?.exitstatus)
        raise ::StandardError, "Error while running #{cmd}: #{output}"
      end

      output
    end

    def self.simple_captcha_value(key) #:nodoc
      SimpleCaptchaData.get_data(key).value rescue nil
    end

    def self.simple_captcha_passed!(key) #:nodoc
      SimpleCaptchaData.remove_data(key)
    end

    def self.generate_key(*args)
      args << Time.now.to_s
      Digest::SHA1.hexdigest(args.join)
    end

    def self.set_simple_captcha_data(key, options={})
      code_type = options[:code_type]

      data = SimpleCaptcha::SimpleCaptchaData.get_data(key)
      data.value = generate_simple_captcha_data(code_type)
      data.save
      key
    end

    def self.generate_simple_captcha_data(code)
      value = ''

      case code
      when 'numeric' then 
        SimpleCaptcha.length.times{value << (48 + rand(10)).chr}
      else
        SimpleCaptcha.length.times{value << (65 + rand(26)).chr}
      end

      return value
    end


    def self.generate_image_url key, *args
      options = args.extract_options!

      defaults = {}
      defaults[:time] = options[:time] || Time.now.to_i

      base_url = args.first || ENV['RAILS_RELATIVE_URL_ROOT']

      url = "#{base_url}/simple_captcha?code=#{key}&#{defaults.to_query}"
    end

    def self.generate_key_use_session session, *args
      options = args.extract_options!
      key_name = args.first

      if key_name.nil?
        session[:captcha] ||= SimpleCaptcha::Utils.generate_key(session[:id].to_s, 'captcha')
      else
        SimpleCaptcha::Utils.generate_key(session[:id].to_s, key_name)
      end
    end
  end
end
