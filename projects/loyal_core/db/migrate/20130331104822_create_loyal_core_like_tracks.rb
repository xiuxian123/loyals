# -*- encoding : utf-8 -*-
class CreateLoyalCoreLikeTracks < ActiveRecord::Migration
  def change
    create_table :loyal_core_like_tracks do |t|
      t.references :target, :polymorphic => true
      t.integer    :created_by
      t.string     :created_ip
      t.integer    :position, :default => 0, :null => false

      t.timestamps
    end

    add_index :loyal_core_like_tracks, [:created_by]

    add_index :loyal_core_like_tracks, [:target_id, :target_type],
      :name => :loyal_core_like_tracks_target

  end
end
