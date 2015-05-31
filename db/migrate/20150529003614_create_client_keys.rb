class CreateClientKeys < ActiveRecord::Migration
  def change
    create_table :client_keys do |t|
      t.references :client, null: false
      t.references :key, null: false
      t.datetime :used_at
      t.boolean :unlimited_access, default: false
      t.boolean :requested, default: false
      t.string :hashify

      t.timestamps null: false
    end
  end
end
