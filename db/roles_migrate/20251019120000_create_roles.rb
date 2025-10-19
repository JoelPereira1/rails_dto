class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.string :role_key, null: false
      t.string :name,     null: false
      t.timestamps
    end

    add_index :roles, :role_key, unique: true
  end
end
