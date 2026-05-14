class AddUniqueIndexToCoursesOnName < ActiveRecord::Migration[8.0]
  def change
    add_index :courses, :name, unique: true
  end
end
