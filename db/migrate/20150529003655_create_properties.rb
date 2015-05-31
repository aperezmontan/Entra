class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.references :user, null: false
      t.references :place, null: false

      t.timestamps null: false
    end
  end
end
