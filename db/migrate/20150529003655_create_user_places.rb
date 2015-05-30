class CreateUserPlaces < ActiveRecord::Migration
  def change
    create_table :user_places do |t|
      t.references :user
      t.references :place

      t.timestamps null: false
    end
  end
end
