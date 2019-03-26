class Deleting < ActiveRecord::Migration[5.2]
  def change
    drop_table :publications_users
  end
end
