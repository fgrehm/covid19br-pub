class Content < ApplicationRecord
  belongs_to :content_source
  has_one :content_text
end
