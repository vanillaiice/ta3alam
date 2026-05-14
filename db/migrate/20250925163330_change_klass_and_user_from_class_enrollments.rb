class ChangeKlassAndUserFromClassEnrollments < ActiveRecord::Migration[8.0]
  def change
    add_index :class_enrollments, [ :klass_id, :user_id ], unique: true
  end
end
