# -*- encoding : utf-8 -*-
# This migration comes from loyal_passport (originally 20121125104021)
class AddSessionsTable < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :session_id, :null => false, :default => ''
      t.text :data
      t.timestamps
    end

    add_index :sessions, :session_id
    add_index :sessions, :updated_at
  end
end
