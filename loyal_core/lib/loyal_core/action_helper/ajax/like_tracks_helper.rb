# -*- encoding : utf-8 -*-
module LoyalCore
  module Ajax
    module LikeTracksHelper
      def loyal_core_helper_ajax_liker_link_to target, options={}
        link_to  "javascript:;", {
          'march-on' => 'ajax',
          'march-type' => 'march-type',
          'march-id' => target.uuid,
          'march-action' => 'like'
        }.merge(options) do
          html = ""
          html << (
            image_tag image_path("loyal_core/liked.gif"), :class => 'liked', :style => "display: #{target.liked_by?(current_user) ? 'inline' : 'none'};"
          )

          html << (
            image_tag image_path("loyal_core/unlike.gif"), :class => 'unlike', :style => "display: #{target.liked_by?(current_user) ? 'none' : 'inline'};"
          )
          html << "<span class='count'>#{target.liked_count}</span>"
          raw html
        end
      end
    end
  end
end
