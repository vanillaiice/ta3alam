class ChangeColumnNullAgainFromCourses < ActiveRecord::Migration[8.0]
  def change
    change_column_null :courses, :name, false
  end
end
