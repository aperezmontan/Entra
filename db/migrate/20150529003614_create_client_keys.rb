class CreateClientKeys < ActiveRecord::Migration
  def change
    create_table :client_keys do |t|
      t.references :client
      t.references :key
      t.datetime :used_at
      t.boolean :requested
      
      t.timestamps null: false
    end
  end
end
