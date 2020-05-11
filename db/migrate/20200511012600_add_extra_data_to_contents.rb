class AddExtraDataToContents < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :extra_data, :jsonb, null: false, default: {}
  end
end
