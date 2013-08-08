# -*- encoding : utf-8 -*-
require 'iconv' unless RUBY_VERSION.respond_to?(:encode)

module LoyalIpinfo

  class Worker
    attr_reader :adapter, :library_file_path

    def initialize attrs={}
      @adapter           ||= (attrs[:adapter] || ::LoyalIpinfo.config.default_adapter)
      @library_file_path ||= (attrs[:library_file_path] || ::LoyalIpinfo.config.default_library_file_path)

      case self.adapter
      when :qqwry
        self.extend ::LoyalIpinfo::QQwryAdapter
      end
    end
  end

  module QQwryAdapter
    def find *args, &block
      options = ::LoyalIpinfo::ArrayUtil.extract_options!(args)

      @qqwry_db ||= QQWry::QQWryFile.new(self.library_file_path)

      result = args.inject({}) do |_result, ip|
        _result[ip] = @qqwry_db.find(ip)
        _result
      end

      if block_given?
        block.call result
      end

      if args.any?
        if args.one?
          result[args.first]
        else
          result
        end
      else
        nil
      end
    end
    module QQWry
      module QQWryIO
        def get_le32
          arr = read(4).unpack("C4")
          arr[0] | arr[1]<<8 | arr[2]<<16 | arr[3]<<24
        end

        def get_le24
          arr = read(3).unpack("C3")
          arr[0] | arr[1]<<8 | arr[2]<<16
        end

        def get_string
          str = ""
          while ((ch = read(1).unpack("a")[0]) != "\x00")
            str += ch
          end
          str
        end

        def get_u8
          read(1).unpack("C")[0]
        end
      end

      module QQWryIpStr
        def ip_str
          [@ip].pack("L").unpack("C4").reverse.join(".")
        end
      end

      class QQWryHeader
        def initialize(file)
          file.seek(0)
          @first = file.get_le32
          @last = file.get_le32
        end
        attr_reader :first, :last
      end

      class QQWryRecord
        include QQWryIpStr

        attr_reader :city, :area

        def initialize(file, pos)
          file.seek(pos)
          @ip = file.get_le32
          case file.get_u8
          when 0x1
            file.seek(pos = file.get_le24)
            case file.get_u8
            when 0x2
              file.seek(file.get_le24)
              @city = file.get_string
              file.seek(pos + 4)
            else
              file.seek(-1, IO::SEEK_CUR)
              @city = file.get_string
            end
            parse_area(file)
          when 0x2
            pos = file.get_le24
            parse_area(file)
            file.seek(pos)
            @city = file.get_string
          else
            file.seek(-1, IO::SEEK_CUR)
            @city = file.get_string
            parse_area(file)
          end

          iconv_city
        end

        attr_reader :ip

        def _conv(str)
          begin
            if str.respond_to?(:encode)
              str.force_encoding('GBK').encode('UTF-8')
            else
              Iconv::conv('UTF-8', 'GBK', str)
            end
          rescue
            str = str[0, str.length - 1]
            retry
          end
        end

        def iconv_city
          @city = _conv @city.to_s
          @city = '' if @city=~ /\s*CZ88\.NET\s*/
        end

        def parse_area(file)
          case file.get_u8
          when 0x2
            if ((pos = file.get_le24) != 0)
              file.seek(pos)
              @area = file.get_string
            else
              @area = ""
            end
          else
            file.seek(-1, IO::SEEK_CUR)
            @area = file.get_string
          end

          @area = _conv(@area.to_s)

          @area = '' if @area =~ /\s*CZ88\.NET\s*/
        end

        private :parse_area
      end

      class QQWryIndex
        include QQWryIpStr

        def initialize(file, pos)
          file.seek(pos)
          @ip = file.get_le32
          @pos = file.get_le24
        end
        attr_reader :ip, :pos
      end

      class QQWryFile
        def initialize(filename = "qqwry.dat")
          @filename = filename
        end

        def each
          File.open(@filename) do |file|
            file.extend QQWryIO
            header = QQWryHeader.new(file)
            pos = header.first
            while pos <= header.last
              index = QQWryIndex.new(file, pos)
              record = QQWryRecord.new(file, index.pos)
              if block_given?
                yield index, record
              else
                puts "#{index.ip_str}-#{record.ip_str} #{record.city}" +
                " #{record.area}"
              end
              pos += 7
            end
          end
        end

        def find(ip)
          if ip.class == String
            ip = ip.split(".").collect{|x| x.to_i}.pack("C4").unpack("N")[0]
          end

          File.open(@filename) do |file|
            file.extend QQWryIO
            header = QQWryHeader.new(file)
            first = header.first
            left = 0
            right = (header.last - first) / 7
            while left <= right
              middle = (left + right) / 2
              middle_index = QQWryIndex.new(file, first + middle * 7)
              if (ip > middle_index.ip)
                left = middle + 1
              elsif (ip < middle_index.ip)
                right = middle - 1
              else
                return QQWryRecord.new(file, middle_index.pos)
              end
            end
            index = QQWryIndex.new(file, first + right * 7)
            return QQWryRecord.new(file, index.pos)
          end
        end
      end
    end
  end
end
