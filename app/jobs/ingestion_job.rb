class IngestionJob < ApplicationJob
  def perform(args = {})
    input, s3_key = args["input"], args["s3_key"]

    raise ArgumentError, "No input or S3 file specified" if input.nil? && s3_key.nil?
    raise ArgumentError, "Can't specify both input AND S3 file" if input.present? && s3_key.present?

    input = { read_from_s3: s3_key } if input.blank?
    result = Ingestion::Runner.run(input)
    if result[:error]
      error = result[:error]
      raise RuntimeError, "#{error[:action]} errored with #{error[:exception]}"
    end
  end
end
