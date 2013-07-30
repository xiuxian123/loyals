# -*- encoding : utf-8 -*-
class CreateLoyalPassportHomeworks < ActiveRecord::Migration
  def change
    create_table :loyal_passport_homeworks do |t|
      t.string :name
      t.string :job_name
      t.integer :role_id

      t.timestamps
    end
  end
end
