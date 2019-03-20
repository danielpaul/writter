class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :commentable_type, allow_nil: false, allow_blank: false
      t.integer :commentable_id, allow_nil: false, allow_blank: false
      t.integer :user_id, allow_nil: false, allow_blank: false
      t.text :body, allow_nil: false, allow_blank: false

      t.timestamps
    end
  end
end
