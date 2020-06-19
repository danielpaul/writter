class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.references :user, foreign_key: true
      t.references :publication, foreign_key: true
      t.string :type, allow_nil: false, allow_blank: false

      t.timestamps
    end
  end
end
