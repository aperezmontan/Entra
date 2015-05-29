class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.references :place
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
