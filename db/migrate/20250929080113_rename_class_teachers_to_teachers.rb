class RenameClassTeachersToTeachers < ActiveRecord::Migration[8.0]
  def change
    rename_table :class_teachers, :teachers
  end
end
