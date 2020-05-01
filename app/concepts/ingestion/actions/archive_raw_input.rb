module Ingestion
  module Actions
    class ArchiveRawInput
      class << self
        def call(env)
          raw_input = env.fetch(:raw_input)

          s3_key = raw_input[:read_from_s3].presence
          if s3_key
            raw_input = read_from_s3(s3_key)
            env[:raw_input] = raw_input
          end

          env[:input_model] = ::Input.archive!(raw_input)
          delete_from_s3(s3_key) if s3_key

          # "Consumes" the information, in theory no other actions should use this info
          env.delete(:s3_key)
        end

        private

        def read_from_s3(key)
          resp = s3.get_object(bucket: input_bucket, key: key)
          JSON.parse(resp.body.string)
        end

        def delete_from_s3(key)
          s3.destroy_object(bucket: input_bucket, key: key)
        end

        def s3
          @s3 ||= Aws::S3::Client.new(region: "us-east-1")
        end

        def input_bucket
          Rails.configuration.x.s3_input_bucket
        end
      end
    end
  end
end
