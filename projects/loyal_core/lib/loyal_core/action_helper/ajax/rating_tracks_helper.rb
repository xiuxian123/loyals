# -*- encoding : utf-8 -*-
module LoyalCore
  module Ajax
    module RatingTracksHelper
      def loyal_core_helper_ajax_up_rating_link_to target, options={}
        link_to  "javascript:;", {
          'march-on' => 'ajax',
          'march-type' => 'target-type',
          'march-id' => target.uuid,
          'march-action' => 'up'
        }.merge(options) do
          html = ''
          html << (image_tag image_path("loyal_core/up_rating.gif"))
          html << "<span class='count'>#{target.up_rating}</span>"
          raw html
        end
      end

      def loyal_core_helper_ajax_down_rating_link_to target, options={}
        link_to  "javascript:;", {
          'march-on' => 'ajax',
          'march-type' => 'target-type',
          'march-id' => target.uuid,
          'march-action' => 'down'
        }.merge(options) do
          html = ''
          html << (image_tag image_path("loyal_core/down_rating.gif"))
          html << "<span class='count'>#{target.down_rating}</span>"
          raw html
        end
      end

    end
  end
end
