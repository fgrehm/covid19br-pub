class CreateScrapedContents < ActiveRecord::Migration[6.0]
  def change
    create_table :scraped_contents do |t|
      t.references :content_source, null: false, foreign_key: true, index: true
      t.references :content, foreign_key: true, index: { unique: true }
      t.string :content_type, null: false, index: true
      t.datetime :first_seen_at, null: false
      t.datetime :last_seen_at, null: false
      t.datetime :detected_removal_at
      t.string :url_hash, index: { unique: true }
      t.text :url

      t.timestamps
    end

    change_table :inputs do |t|
      t.references :scraped_content, foreign_key: true, index: true
    end
  end
end
