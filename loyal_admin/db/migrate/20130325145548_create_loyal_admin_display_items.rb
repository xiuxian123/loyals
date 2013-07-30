# -*- encoding : utf-8 -*-
class CreateLoyalAdminDisplayItems < ActiveRecord::Migration
  def change
    create_table :loyal_admin_display_items do |t|
      t.integer :board_id
      t.integer :position, :default => 0, :null => false # 置顶排序
      t.references :target, :polymorphic => true

      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end

    add_index :loyal_admin_display_items, [:board_id]
    add_index :loyal_admin_display_items, [:target_id, :target_type], :name => :loyal_admin_display_items_target
  end
end
