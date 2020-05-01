module Ingestion
  module Actions
    class UpsertContent
      def self.call(env)
        return unless env[:relevant]

        params = env.fetch(:input).slice(
          :source_guid,
          :content_type,
          :found_at,
          :published_at,
          :modified_at,
          :image_url,
          :title,
          :url_hash,
          :url,
          :excerpt,
          :full_text
        )

        params[:display_text] = params[:excerpt].truncate(1_000) if params[:excerpt]
        params[:display_text] ||= params.fetch(:full_text).truncate(1_000)

        content_source = ::ContentSource.find_by!(guid: params.delete(:source_guid))
        url_hash = params.delete(:url_hash)

        content = ::Content.find_or_initialize_by(
          content_source: content_source,
          url_hash: url_hash
        )
        content.update!(params)

        input_model = env[:input_model].presence
        input_model.update!(content: content) if input_model

        env[:content] = content
      end
    end
  end
end
