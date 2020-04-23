class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.references :content_source, null: false, foreign_key: true, index: true
      t.string :uuid, null: false, index: { unique: true }
      t.string :content_type, null: false, index: true
      t.datetime :found_at, null: false, index: true
      t.datetime :published_at, null: false, index: true
      t.datetime :modified_at
      t.text :image_url
      t.string :title
      t.string :display_text, null: false
      t.string :url_hash, null: false, index: { unique: true }
      t.text :url, null: false

      t.timestamps
    end

    create_table :content_texts do |t|
      t.references :content, null: false, foreign_key: true, index: { unique: true }
      t.text :excerpt
      t.string :full_text_hash, null: false, index: true
      t.text :full_text

      t.timestamps
    end
  end
end
