class IngestionJob < ApplicationJob
  def perform(args = {})
    input, s3_key, input_model_id = args.values_at("input", "s3_key", "input_model_id")

    raise ArgumentError, "Need to specify at least one arg" if [input, s3_key, input_model_id].all?(&:blank?)
    raise ArgumentError, "Can't specify multiple args" if [input, s3_key, input_model_id].count(&:present?) > 1

    input = { read_from_s3: s3_key } if s3_key.present?
    input = { input_model: Input.find(input_model_id) } if input_model_id.present?

    result = Ingestion::Runner.run(input)
    if result[:error]
      error = result[:error]
      raise RuntimeError, "#{error[:action]} errored with #{error[:exception]}"
    end
  end
end
