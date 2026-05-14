class RemoveOrganizationFromCourses < ActiveRecord::Migration[8.0]
  def change
    remove_reference :courses, :organization, null: false, foreign_key: true
  end
end
