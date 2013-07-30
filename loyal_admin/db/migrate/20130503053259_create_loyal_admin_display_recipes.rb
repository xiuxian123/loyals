# -*- encoding : utf-8 -*-
class CreateLoyalAdminDisplayRecipes < ActiveRecord::Migration
  def change
    create_table :loyal_admin_display_recipes do |t|
      t.string :url   # url链接
      t.string :text
      t.string :title
      t.text   :content

      t.string :style # 样式表

      t.integer :publish_status

      t.integer :open_style

      t.datetime :start_at
      t.datetime :end_at
      
      t.timestamps
    end
  end
end
