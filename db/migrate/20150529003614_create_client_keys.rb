class CreateClientKeys < ActiveRecord::Migration
  def change
    create_table :client_keys do |t|
      t.references :client, null: false
      t.references :key, null: false
      t.datetime :used_at, null: false
      t.boolean :unlimited_access, null:false
      t.boolean :requested, null: false

      t.timestamps null: false
    end
  end
end
