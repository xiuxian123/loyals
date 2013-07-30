# -*- encoding : utf-8 -*-
class CreateLoyalCoreSkinFolders < ActiveRecord::Migration
  def change
    create_table :loyal_core_skin_folders do |t|
      t.string  :name             #名称
      t.string  :short_name       #简称

      t.integer :publish_status, :default => 0, :null => false

      t.integer :created_by
      t.string  :created_ip

      # 简介
      t.string  :instroduction

      # 描述
      t.text    :description

      t.integer :lang, default: 0, :null => false  #语言

      t.string :uuid

      t.string  :space      #命名空间
      t.string :permalink

      ###### avatar #############################
      t.string :avatar

      ###### for nested_ful #####################
      t.integer :parent_id
      t.integer :left_id
      t.integer :right_id
      t.integer :depth
      t.integer :children_count, default: 0

      ##### soft deleted #######################
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :loyal_core_skin_folders, [:uuid]
    add_index :loyal_core_skin_folders, [:space, :permalink]
    add_index :loyal_core_skin_folders, [:parent_id]
    add_index :loyal_core_skin_folders, [:left_id]
    add_index :loyal_core_skin_folders, [:right_id]
  end
end
