class RemoveContentTypeFromClassContents < ActiveRecord::Migration[8.0]
  def change
    remove_column :class_contents, :content_type, :string
  end
end
