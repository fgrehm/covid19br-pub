class Input < ApplicationRecord
  belongs_to :content, optional: true
  has_one_attached :file

  after_initialize(unless: :persisted?) do
    self.uuid = SecureRandom.uuid if self.uuid.blank?
  end

  def self.archive!(raw_input)
    key, found_at = raw_input.values_at("key", "found_at")
    raise RuntimeError, "key not set" if key.blank?
    raise RuntimeError, "found_at not set" if found_at.blank?

    found_at = DateTime.parse(found_at)
    self.find_or_initialize_by(key: key, found_at: found_at).tap do |input|
      input.archive!(raw_input) if !input.file.attached?
    end
    # attach file, use proper key (found at + input key)
  end

  def archive!(raw_input)
    self.save! # So we get an ID
    timestamp = self.updated_at.strftime("%Y-%m-%d--%H-%M-%S")

    # https://stackoverflow.com/a/52181467 custom prefix, ugly workaround for
    # the fact that activestorage does not support key prefixes for S3. More
    # info can also be found on https://github.com/rails/rails/issues/32790
    blob = ActiveStorage::Blob.new(
      key: "inputs/#{self.uuid}/#{timestamp}.json.gz",
      filename: "#{timestamp}.json.gz",
      content_type: "application/gzip"
    ).tap do |blob|
      blob.upload(StringIO.new(ActiveSupport::Gzip.compress(raw_input.to_json)))
      # This will analyze and save, instead of the default behavior of active
      # storage that analyzes from a background job.
      blob.analyze
    end

    self.file.attach(blob)
  end

  # TO Read: JSON.parse(ActiveSupport::Gzip.decompress(Input.last.file.download))
end
