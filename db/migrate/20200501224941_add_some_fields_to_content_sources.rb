class AddSomeFieldsToContentSources < ActiveRecord::Migration[6.0]
  def change
    add_column :content_sources, :source_type, :string
    add_column :content_sources, :source_scope, :string
    add_column :content_sources, :logo_url, :string
    add_column :content_sources, :cloudinary_image_id, :string

    # Just so we can make the column not null, it'll be updated later with the
    # seed script
    execute "UPDATE content_sources SET source_type = 's', source_scope = 's'"

    change_column_null :content_sources, :source_scope, false
    change_column_null :content_sources, :source_type, false
  end
end
