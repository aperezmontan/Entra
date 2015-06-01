class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.references :place, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.references :guest, null: false
      t.datetime :used_at
      t.boolean :requested, default: false, null: false
      t.string :secret_url, null: false

      t.timestamps null: false
    end
  end
end
