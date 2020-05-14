class ContentSearch
  def self.call(query: nil, page: nil, state_code: nil, content_source: nil)
    documents = SearchDocument.order(published_at: :desc)

    documents = documents.where(state: state_code) if state_code.present?
    documents = documents.where(content_source: content_source) if content_source.present?
    documents = documents.search(query) if query.present?
    documents = documents.page(page) if page
    Results.new(documents)
  end

  class Results
    delegate :each, :to_a, to: :@contents
    delegate :total_count, :last_page?, to: :@documents

    def initialize(documents)
      @documents = documents
      @contents = Content.where(id: documents.select(:content_id)).order(published_at: :desc).includes(:content_source)
    end

    def total_count
      return @documents.total_count if @documents.respond_to?(:total_count)

      @documents.count
    end

    def any?
      # This is to load the records in memory instead of executing a COUNT
      to_a.any?
    end

    def tweets_count
      @tweets_count ||= @documents.except(:limit, :offset).where(content_type: "tweet").count
    end

    def articles_count
      @articles_count ||= @documents.except(:limit, :offset).where(content_type: "article").count
    end
  end
end
