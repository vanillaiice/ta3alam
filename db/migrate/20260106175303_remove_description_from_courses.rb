class RemoveDescriptionFromCourses < ActiveRecord::Migration[8.0]
  def change
    remove_column :courses, :description, :text
  end
end
