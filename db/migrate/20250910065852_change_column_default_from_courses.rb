class ChangeColumnDefaultFromCourses < ActiveRecord::Migration[8.0]
  def change
    change_column_default :courses, :name, from: "f", to: nil
    change_column_default :courses, :number, from: 1, to: nil
  end
end
