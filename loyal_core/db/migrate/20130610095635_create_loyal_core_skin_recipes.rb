# -*- encoding : utf-8 -*-
class CreateLoyalCoreSkinRecipes < ActiveRecord::Migration
  def change
    create_table :loyal_core_skin_recipes do |t|
      t.integer :folder_id

      t.string :name
      t.string :short_name

      t.string :avatar
      t.string :stored_tags

      t.string :assets_path
      t.text :stylesheet_text

      t.integer :created_by
      t.string  :created_ip

      # 简介
      t.string  :instroduction

      # 描述
      t.text    :description

      t.timestamps
    end
  end
end
