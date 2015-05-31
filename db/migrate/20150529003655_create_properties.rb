class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.references :user
      t.references :place

      t.timestamps null: false
    end
  end
end
