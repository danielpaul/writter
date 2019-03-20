class CreatePublications < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    create_table :publications do |t|
      t.string :title, allow_nil: false, allow_blank: false
      t.text :description, allow_nil: false, allow_blank: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_reference :articles, :publication, foreign_key: true, allow_nil: true, allow_blank: false, index: false
    add_index :articles, :publication_id, algorithm: :concurrently
  end
end
