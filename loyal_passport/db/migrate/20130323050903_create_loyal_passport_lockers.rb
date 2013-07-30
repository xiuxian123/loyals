# -*- encoding : utf-8 -*-
class CreateLoyalPassportLockers < ActiveRecord::Migration
  def change
    create_table :loyal_passport_lockers do |t|
      t.references :target
      t.integer    :owner_id

      t.integer :position, default: 0, null: false

      # 发布状态 ###############################
      t.integer :publish_status, default: 0

      # 级别 #################################
      t.integer :level, default: 0, null: false

      t.timestamps
    end
  end
end
