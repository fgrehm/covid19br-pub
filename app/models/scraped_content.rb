class ScrapedContent < ApplicationRecord
  belongs_to :content_source
  belongs_to :content, optional: true
  has_many :inputs
end
