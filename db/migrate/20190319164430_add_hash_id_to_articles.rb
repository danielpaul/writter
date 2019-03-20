class AddHashIdToArticles < ActiveRecord::Migration[5.2]
  def up
    add_column :articles, :hash_id, :string, index: true
    Article.all.each{|m| m.set_hash_id; m.save}
  end
  def down
    remove_column :articles, :hash_id, :string
  end
end
