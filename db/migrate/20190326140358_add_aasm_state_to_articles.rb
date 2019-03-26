class AddAasmStateToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :aasm_state, :string
  end
end
