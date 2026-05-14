class AddTitleAndDescriptionToClassContents < ActiveRecord::Migration[8.0]
  def change
    add_column :class_contents, :title, :string
    add_column :class_contents, :description, :text
  end
end
