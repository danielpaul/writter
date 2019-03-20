class AddingIndexToComments < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :comments, [:commentable_id, :commentable_type], algorithm: :concurrently
  end
end
