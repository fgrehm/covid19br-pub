class RemoveCoupleFieldsFromInputs < ActiveRecord::Migration[6.0]
  def change

    remove_column :inputs, :content_id, :bigint

    remove_column :inputs, :updated_at, :datetime
  end
end
