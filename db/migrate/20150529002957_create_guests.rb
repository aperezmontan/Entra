class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.string :email, null: false
      t.references :user, null: false

      t.timestamps null: false
    end
  end
end
