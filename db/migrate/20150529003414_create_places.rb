class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.text :address
      t.string :nick_name
      t.integer :admin_id
      t.references :user

      t.timestamps null: false
    end
  end
end
