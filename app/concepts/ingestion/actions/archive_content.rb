module Ingestion
  module Actions
    class ArchiveContent
      class << self
        # Not only in S3 but also wayback machine / archive.is and the input payload
        # (as a separate attachment), see if can dowload from wayback machine, at
        # very least use a collection
        def call(env)
          return unless env.key?(:content)

          content = env.fetch(:content)
          return if content.previous_changes.blank?

          snapshot = content.as_json
          snapshot.merge!(content.content_text.as_json.except("id", "content_id", "created_at", "updated_at"))
          snapshot["source_guid"] = ContentSource.find(snapshot.delete("content_source_id")).guid

          content.versions.attach(create_archive_blob(content, snapshot.to_json))
          # Enqueue job for wayback machine & archive.is separate?
        end

        private

        def create_archive_blob(content, snapshot)
          # https://stackoverflow.com/a/52181467 custom prefix, ugly workaround for
          # the fact that activestorage does not support key prefixes for S3. More
          # info can also be found on https://github.com/rails/rails/issues/32790
          timestamp = content.updated_at.strftime("%Y-%m-%d--%H-%M-%S")
          ActiveStorage::Blob.new(
            key: "contents/#{content.uuid}/versions/#{timestamp}.json.gz",
            filename: "#{timestamp}.json.gz",
            content_type: "application/gzip"
          ).tap do |blob|
            blob.upload(StringIO.new(ActiveSupport::Gzip.compress(snapshot)))
            # This will analyze and save, instead of the default behavior of active
            # storage that analyzes from a background job.
            blob.analyze
          end
        end
      end
    end
  end
end
