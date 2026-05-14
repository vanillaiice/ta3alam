class ChangeDescriptionStringToTextFromCourses < ActiveRecord::Migration[8.0]
  def change
    change_column :courses, :description, :text
  end
end
