class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :message, null: false
      t.references :loggable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
