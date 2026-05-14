class RenameClassEnrollmentsToSudents < ActiveRecord::Migration[8.0]
  def change
    rename_table :class_enrollments, :students
  end
end
