module Ingestion
  module Actions
    class UpsertScrapedContent
      def self.call(env)
        params = env.fetch(:input).slice(:source_guid, :content_type, :found_at, :url_hash, :url)

        # TODO: Consider storing the content source on env
        content_source = ::ContentSource.find_by!(guid: params.delete(:source_guid))
        url_hash = params.delete(:url_hash)

        scraped_content = ::ScrapedContent.find_or_initialize_by(
          content_source: content_source,
          url_hash: url_hash
        )

        found_at = params.delete(:found_at)
        if scraped_content.first_seen_at.nil? || found_at < scraped_content.first_seen_at
          scraped_content.first_seen_at = found_at
        end
        if scraped_content.last_seen_at.nil? || found_at > scraped_content.last_seen_at
          scraped_content.last_seen_at = found_at
        end
        scraped_content.update!(params)

        input_model = env[:input_model].presence
        input_model.update!(scraped_content: scraped_content) if input_model

        env[:scraped_content] = scraped_content
      end
    end
  end
end
