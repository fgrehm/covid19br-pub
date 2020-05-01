class CreateInputs < ActiveRecord::Migration[6.0]
  def change
    create_table :inputs do |t|
      t.string :uuid, null: false, index: { unique: true }
      t.string :key, null: false
      t.datetime :found_at, null: false
      t.references :content, null: true, foreign_key: true, index: true

      t.index [:key, :found_at], unique: true
      t.timestamps
    end
  end
end
