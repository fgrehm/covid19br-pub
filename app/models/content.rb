class Content < ApplicationRecord
  attr_readonly :uuid

  belongs_to :content_source
  has_one :content_text, dependent: :destroy
  has_many_attached :versions

  delegate :full_text, :full_text=, :excerpt, :excerpt=, :full_text_hash,
           to: :content_text

  after_initialize(unless: :persisted?) do
    self.uuid = SecureRandom.uuid if self.uuid.blank?
  end
  after_save(if: :requires_reindexing?) do
     SearchDocument.index!(self)
  end

  def requires_reindexing?
    previous_changes.any? || content_text.previous_changes.any?
  end

  def display_text=(display_text)
    super(display_text.truncate(450))
  end

  def content_text
    super || build_content_text
  end
end
