# -*- encoding : utf-8 -*-
class CreateLoyalPassportAssignments < ActiveRecord::Migration
  def change
    create_table :loyal_passport_assignments do |t|
      t.integer :user_id
      t.integer :role_id

      t.integer :position, default: 0, null: false

      # 发布状态 ###############################
      t.integer :publish_status_value, default: 0, null: false

      # 级别 #################################
      t.integer :level_value, default: 0, null: false

      t.datetime :deleted_at

      t.timestamps
    end

    add_index :loyal_passport_assignments, [:user_id]
    add_index :loyal_passport_assignments, [:role_id]
  end
end
