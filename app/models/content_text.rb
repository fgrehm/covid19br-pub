class ContentText < ApplicationRecord
  belongs_to :content, touch: true

  def full_text=(full_text)
    super.tap do
      self.full_text_hash = Digest::SHA1.hexdigest(full_text) if full_text_changed?
    end
  end
end
