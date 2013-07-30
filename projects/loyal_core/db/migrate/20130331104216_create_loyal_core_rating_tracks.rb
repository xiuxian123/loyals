# -*- encoding : utf-8 -*-
class CreateLoyalCoreRatingTracks < ActiveRecord::Migration
  def change
    create_table :loyal_core_rating_tracks do |t|
      t.references :target, :polymorphic => true
      t.integer    :created_by
      t.string     :created_ip
      t.integer    :score, :default => 0, :null => false

      t.timestamps
    end

    add_index :loyal_core_rating_tracks, [:created_by]

    add_index :loyal_core_rating_tracks, [:target_id, :target_type],
      :name => :loyal_core_rating_tracks_target

  end
end
