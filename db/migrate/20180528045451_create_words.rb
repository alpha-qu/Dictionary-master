class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :text, unique: true, null: false
      t.string :sorted, null: false

      t.timestamps null: false
    end
  end
end
