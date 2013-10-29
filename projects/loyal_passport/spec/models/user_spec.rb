# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ::User do
  fixtures :users

  it 'super_admin' do
    user = users(:one)

    user.should_not be_nil
    user.super_admin?.should be_true
  end


end
