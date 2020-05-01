module Ingestion
  module Actions
    # This action takes care of loading and archiving inputs before they are
    # consumed by other actions.
    class ProcessInput
      class << self
        def call(env)
          raw_input = env.fetch(:raw_input)
          input_model = raw_input.delete(:input_model).presence
          s3_key = raw_input.delete(:read_from_s3).presence

          if input_model
            raw_input = input_model.data
          elsif s3_key
            raw_input = read_from_s3(env, s3_key)
          end

          input_model ||= ::Input.archive!(raw_input)
          env[:s3_input_object]&.delete

          env[:input_model] = input_model
          env[:raw_input] = raw_input
        end

        private

        def read_from_s3(env, s3_key)
          env[:s3_input_bucket] ||= fetch_bucket_resource
          env[:s3_input_object] = env[:s3_input_bucket].object(s3_key)
          @raw_input = JSON.parse(env[:s3_input_object].get.body.string)
        end

        def fetch_bucket_resource
          s3 = Aws::S3::Resource.new(region: "us-east-1")
          s3.bucket(Rails.configuration.x.s3_input_bucket)
        end
      end
    end
  end
end
