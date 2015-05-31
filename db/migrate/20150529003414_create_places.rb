class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.text :address, null: false
      t.string :nick_name, null: false
      t.integer :admin_id, null: false
      t.references :user, null: false

      t.timestamps null: false
    end
  end
end
