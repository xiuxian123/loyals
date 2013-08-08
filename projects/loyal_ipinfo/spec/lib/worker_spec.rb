# -*- encoding : utf-8 -*-
require 'spec_helper'

module LoyalIpinfo
  describe Worker do
    context "#initialize" do
      it '本地地址 success' do
        worker = ::LoyalIpinfo::Worker.new

        result = worker.find('127.0.0.1')

        result.city.should == '本机地址'
        result.area.should == ''
      end

      it '测试一个美国ip' do
        worker = ::LoyalIpinfo::Worker.new

        result = worker.find('199.231.64.103')
        result.city.should == '美国'
        result.area.should == ''
      end

      it '测试一个google的ip' do
        worker = ::LoyalIpinfo::Worker.new

        result = worker.find('74.125.235.197')
        result.city.should == '美国'
        result.area.should == '加利福尼亚州圣克拉拉县山景市谷歌公司'
      end

      it '测试一个百度的ip' do
        worker = ::LoyalIpinfo::Worker.new

        result = worker.find('119.75.217.56')
        result.city.should == '北京市'
        result.area.should == '北京百度网讯科技有限公司'
      end

      it '测试一个腾讯的ip' do
        worker = ::LoyalIpinfo::Worker.new

        result = worker.find('220.181.138.29')
        result.city.should == '北京市'
        result.area.should == '电信互联网数据中心'
      end

    end
  end
end
