class AddingEnums < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :state, :integer, default: 0
  end
end
