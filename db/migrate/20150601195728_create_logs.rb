class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.references :key, null: false
      t.text :messages, null: false

      t.timestamps null: false
    end
  end
end
