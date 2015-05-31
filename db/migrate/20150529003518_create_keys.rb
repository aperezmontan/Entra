class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.references :place, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.timestamps null: false
    end
  end
end
