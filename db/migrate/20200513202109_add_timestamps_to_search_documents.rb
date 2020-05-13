class AddTimestampsToSearchDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :search_documents, :created_at, :datetime
    add_column :search_documents, :updated_at, :datetime

    execute "UPDATE search_documents SET created_at = NOW(), updated_at = NOW()"

    change_column_null :search_documents, :created_at, false
    change_column_null :search_documents, :updated_at, false
  end
end
