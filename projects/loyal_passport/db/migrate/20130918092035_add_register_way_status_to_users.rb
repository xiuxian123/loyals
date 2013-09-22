class AddRegisterWayStatusToUsers < ActiveRecord::Migration
  def change
    # 注册方式
    add_column :users, :register_way_status, :integer, :default => 0, :null => false
  end
end
