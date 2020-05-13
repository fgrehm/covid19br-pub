class SearchDocument < ApplicationRecord
  include PgSearch::Model

  belongs_to :content_source
  belongs_to :content

  # TODO: Implement a way to reindex on the background, trigger indexing after
  # ingestion, etc.. Remove accents from original strings, implement unnaccent
  # on the search method as well

  pg_search_scope :raw_search, against: %i[ title excerpt full_text ],
                               using: {
                                 tsearch: {
                                   dictionary: "portuguese",
                                   tsvector_column: "searchable"
                                 }
                               }

  def self.index!(content)
    find_or_initialize_by(content: content).update!(
      content_source: content.content_source,
      content_type: content.content_type,
      state: content.content_source.state,
      title: I18n.transliterate(content.title || ""),
      excerpt: I18n.transliterate(content.excerpt || ""),
      full_text: I18n.transliterate(content.full_text || ""),
      published_at: content.published_at
    )
  end

  def self.search(query)
    raw_search(I18n.transliterate(query))
  end
end
