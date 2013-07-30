# -*- encoding : utf-8 -*-
module LoyalCore
  DEFAULT_CLAZZ_ALIAS = ::LoyalCore::DataUtil.new(
    :like_track   => 'LoyalCore::LikeTrack',
    :rating_track => 'LoyalCore::RatingTrack'
  )


  SANITIZED_CONFIGS = {
    :relaxed => {        # 宽松的
      :elements => %w[
          a abbr b bdo blockquote br caption cite code col colgroup dd del dfn dl
          dt em figcaption figure h1 h2 h3 h4 h5 h6 hgroup i img ins kbd li mark
          ol p pre q rp rt ruby s samp small strike strong sub sup table tbody td
          tfoot th thead time tr u ul var wbr span code
      ],

      :attributes => {
        :all         => ['dir', 'lang', 'title', 'style', 'name', 'id'],
        'a'          => ['href', 'target', 'name', 'title'],
        'blockquote' => ['cite'],
        'col'        => ['span', 'width'],
        'colgroup'   => ['span', 'width'],
        'del'        => ['cite', 'datetime'],
        'img'        => ['align', 'alt', 'height', 'src', 'width', 'title'],
        'ins'        => ['cite', 'datetime'],
        'ol'         => ['start', 'reversed', 'type'],
        'q'          => ['cite'],
        'table'      => ['summary', 'width', 'border', 'bordercolor'],
        'td'         => ['abbr', 'axis', 'colspan', 'rowspan', 'width'],
        'th'         => ['abbr', 'axis', 'colspan', 'rowspan', 'scope', 'width'],
        'time'       => ['datetime', 'pubdate'],
        'ul'         => ['type'],
        'pre'        => ['class', 'lang'],
        'code'       => ['class']
      },

      :protocols => {
        'a'          => {'href' => ['ftp', 'http', 'https', 'mailto', :relative]},
        'blockquote' => {'cite' => ['http', 'https', :relative]},
        'del'        => {'cite' => ['http', 'https', :relative]},
        'img'        => {'src'  => ['http', 'https', :relative]},
        'ins'        => {'cite' => ['http', 'https', :relative]},
        'q'          => {'cite' => ['http', 'https', :relative]}
      }
    },

    :restricted => {
      :elements => %w[b em i strong u]
    },

    :basic => {
      :elements => %w[
          a abbr b blockquote br cite code dd dfn dl dt em i kbd li mark ol p pre
          q s samp small strike strong sub sup time u ul var
      ],

        :attributes => {
        'a'          => ['href', 'target'],
        'abbr'       => ['title'],
        'blockquote' => ['cite'],
        'dfn'        => ['title'],
        'q'          => ['cite'],
        'time'       => ['datetime', 'pubdate']
      },

      :add_attributes => {
        'a' => {'rel' => 'nofollow'}
      },

      :protocols => {
        'a'          => {'href' => ['ftp', 'http', 'https', 'mailto', :relative]},
        'blockquote' => {'cite' => ['http', 'https', :relative]},
        'q'          => {'cite' => ['http', 'https', :relative]}
      }
    },
    :text => {

    }
  }.freeze


  class << self
    attr_accessor :config
    def configure
      yield self.config ||= Config.new
    end
  end

  class Config
    # 头像的server
    def avatar_server= server=''
      @avatar_server ||= server
    end

    def avatar_server
      @avatar_server ||= ''
    end

    def clazz_alias= ali={}
      @clazz_alias ||= (
        DEFAULT_CLAZZ_ALIAS.deep_merge(
          ali
        )
      )
    end

    def clazz_alias
      @clazz_alias ||= DEFAULT_CLAZZ_ALIAS
    end

    def sanitize_config
      SANITIZED_CONFIGS
    end
  end
end
