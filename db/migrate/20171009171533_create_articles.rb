class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|

      t.string :title
      t.string :slug
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end
end
