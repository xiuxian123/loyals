= LoyalIpinfo

get ip info

eg:

```ruby
# config

LoyalIpinfo.configure do |config|
  # config.default_adapter = :qqwry
  # config.default_library_file_path = ''  # library_file_path
end

# usage:

worker = ::LoyalIpinfo::Worker.new

result = worker.find('127.0.0.1')

result.city # '本机地址'
result.area # ''

```

