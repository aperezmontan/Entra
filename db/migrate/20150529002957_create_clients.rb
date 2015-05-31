class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone, null: false
      t.references :user, null: false
      t.string :email, null: false

      t.timestamps null: false
    end
  end
end
