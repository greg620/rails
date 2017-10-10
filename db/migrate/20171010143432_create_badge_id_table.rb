class CreateBadgeIdTable < ActiveRecord::Migration[5.1]
  def change
    create_table :badge_id do |t|
      t.integer :user_id
      t.integer :badge_id
    end
  end
end
