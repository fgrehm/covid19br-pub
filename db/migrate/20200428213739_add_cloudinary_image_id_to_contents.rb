class AddCloudinaryImageIdToContents < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :cloudinary_image_id, :string
  end
end
