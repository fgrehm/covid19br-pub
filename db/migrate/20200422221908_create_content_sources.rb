class CreateContentSources < ActiveRecord::Migration[6.0]
  def change
    create_table :content_sources do |t|
      t.string :guid, null: false, index: { unique: true }
      t.string :name, null: false, index: { unique: true }
      t.string :region, null: false, index: true
      t.string :state, null: false, index: true
      t.string :twitter
      t.text :site

      t.timestamps
    end
  end
end
