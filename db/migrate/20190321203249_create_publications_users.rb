class CreatePublicationsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :publications_users do |t|
      t.references :publication, foreign_key: true
      t.references :user, foreign_key: true

      t.column :role, :integer

      t.timestamps
    end
  end
end
