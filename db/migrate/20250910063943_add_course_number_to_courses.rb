class AddCourseNumberToCourses < ActiveRecord::Migration[8.0]
  def change
    add_column :courses, :number, :integer, null: false
  end
end
