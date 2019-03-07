class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|

      t.timestamps
      t.string :title, null: false
      t.string :text, null: false
      t.references :user, foreign_key: true
    end
  end
end
