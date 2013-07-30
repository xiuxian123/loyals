# -*- encoding : utf-8 -*-
require "spec_helper"

describe ::LoyalCore::TextUtil do
  let :util do
    ::LoyalCore::TextUtil
  end

  it 'markdown' do
    text = <<-TEXT

``` ruby
puts 'hello world'
```

# hello world
    TEXT

    puts util.markdown(text)
  end

end
