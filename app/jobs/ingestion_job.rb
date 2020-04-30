class IngestionJob < ApplicationJob
  def perform(args = {})
    input, s3_key = args["input"], args["s3_key"]

    raise ArgumentError, "No input or S3 file specified" if input.nil? && s3_key.nil?
    raise ArgumentError, "Can't specify both input AND S3 file" if input.present? && s3_key.present?

    input = read_s3_input(s3_key) if s3_key.present?
    result = Ingestion::Runner.run(input)
    if result[:error]
      error = result[:error]
      raise RuntimeError, "#{error[:action]} errored with #{error[:exception]}"
    end
  end

  private

  def read_s3_input(s3_key)
    s3 = Aws::S3::Client.new(region: "us-east-1")
    resp = s3.get_object(bucket: Rails.configuration.x.s3_input_bucket, key: "#{s3_key}")
    JSON.parse(resp.body.string)
  end
end
