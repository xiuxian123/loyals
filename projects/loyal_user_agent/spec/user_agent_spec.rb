require 'user_agent'

describe UserAgent do
  it 'mobile?' do
    ua = ::UserAgent.new('Mozilla/5.0 (iPhone; U; CPU iPhone OS 3_0 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) Version/4.0 Mobile/7A341 Safari/528.16')

    ua.mobile_device?.should be_true
  end

  it 'not mobile?' do
    ua = ::UserAgent.new('Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.3) Gecko/20100423 Ubuntu/10.04 (lucid) Firefox/3.6')

    ua.mobile_device?.should be_false
  end

end
