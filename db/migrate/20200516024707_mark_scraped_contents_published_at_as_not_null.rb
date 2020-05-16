class MarkScrapedContentsPublishedAtAsNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :scraped_contents, :published_at, false
  end
end
