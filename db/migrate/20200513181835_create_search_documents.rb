class CreateSearchDocuments < ActiveRecord::Migration[6.0]
  # Based on https://pganalyze.com/blog/full-text-search-ruby-rails-postgres

  def up
    create_table :search_documents do |t|
      t.references :content_source, null: false, foreign_key: true, index: true
      t.references :content, null: false, foreign_key: true, index: { unique: true }
      t.string :content_type, null: false
      t.string :state, null: false
      t.string :title
      t.text :excerpt
      t.text :full_text, null: false
      t.datetime :published_at, null: false, index: true

      t.index [:state, :published_at]
    end

    execute <<-SQL
      ALTER TABLE search_documents
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
        to_tsvector('portuguese', coalesce(title, '')) ||
        to_tsvector('portuguese', coalesce(excerpt, '')) ||
        to_tsvector('portuguese', coalesce(full_text, ''))
      ) STORED;
    SQL

    add_index :search_documents, :searchable, using: :gin

    execute <<~SQL
      INSERT INTO search_documents
        (content_id, content_source_id, content_type, state, title, excerpt, full_text, published_at)
      SELECT
        c.id AS content_id,
        c.content_source_id,
        c.content_type,
        cs.state,
        c.title,
        ct.excerpt,
        ct.full_text,
        c.published_at
      FROM contents c
        JOIN content_texts ct
          ON c.id = ct.content_id
        JOIN content_sources cs
          ON cs.id = c.content_source_id
    SQL
  end

  def down
    drop_table :search_documents
  end
end
