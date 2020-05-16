class AddPublishedAtToScrapedContents < ActiveRecord::Migration[6.0]
  def change
    add_column :scraped_contents, :published_at, :datetime
  end
end
