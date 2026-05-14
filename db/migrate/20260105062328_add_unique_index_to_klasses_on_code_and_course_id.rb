class AddUniqueIndexToKlassesOnCodeAndCourseId < ActiveRecord::Migration[8.0]
  def change
    add_index :klasses, [ :code, :course_id ], unique: true
  end
end
