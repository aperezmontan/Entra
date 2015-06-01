class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.text :address, null: false
      t.string :nickname, null: false
      t.integer :admin_id, null: false
      t.boolean :master_unlock, default: false, null: false

      t.timestamps null: false
    end
  end
end
