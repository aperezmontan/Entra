class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, null: false
      t.references :client_keys, null: false
      t.string :message

      t.timestamps null: false
    end
  end
end
