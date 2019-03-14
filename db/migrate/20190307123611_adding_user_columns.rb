# frozen_string_literal: true

class AddingUserColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string, index: true, allow_blank: false, allow_nil: false
    add_column :users, :first_name, :string, allow_nil: false, allow_blank: false
    add_column :users, :last_name, :string, allow_nil: false, allow_blank: false
    add_column :users, :bio, :string
  end
end
