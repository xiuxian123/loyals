# -*- encoding : utf-8 -*-
module LoyalPassport
  module DeviseHelper
    def devise_error_messages!
      return "" if resource.errors.empty?
      messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
      sentence = I18n.t(
        "loyal_passport.form.submit",
        :count => resource.errors.count
      )

      html = <<-HTML
    <div class="error-explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
      HTML

      html.html_safe
    end
  end
end
