class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :external_id
      t.string :email
      t.string :name
      t.string :locale
      t.boolean :active

      t.timestamps
    end
    add_index :users, :external_id
    add_index :users, :email
  end
end
