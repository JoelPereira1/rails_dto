class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :external_id, index: true
      t.string :email, index: true
      t.string :name
      t.string :locale
      t.boolean :active
      t.string :role_key, index: true

      t.timestamps
    end
    add_index :users, :external_id
    add_index :users, :email
    add_index :users, :role_key
  end
end
