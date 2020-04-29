module Ingestion
  module Actions
    class CaptureImage
      class << self
        def call(env)
          return unless env.key?(:content)
          return unless Rails.configuration.x.cloudinary_enabled

          content = env.fetch(:content)
          if content.image_url?
            ingest_image(content)
          else
            delete_image(content)
          end
        rescue CloudinaryException => e
          # TODO: Report error
        end

        private

        def delete_image(content)
          return unless content.cloudinary_image_id?

          Cloudinary::Uploader.destroy(content.cloudinary_image_id)
        end

        def ingest_image(content)
          # HACK: This will break if another action updates the content before
          #       it hits this previous_changes check
          return if !content.previous_changes.key?("image_url") && content.cloudinary_image_id?

          existing_id = content.cloudinary_image_id

          public_id = Cloudinary::Uploader.upload(content.image_url).fetch("public_id")
          content.update!(cloudinary_image_id: public_id)

          Cloudinary::Uploader.destroy(existing_id) if existing_id.present?
        end
      end
    end
  end
end
