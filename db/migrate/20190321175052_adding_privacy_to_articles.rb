class AddingPrivacyToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :privacy, :integer
  end
end
