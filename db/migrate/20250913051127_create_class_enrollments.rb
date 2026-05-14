class CreateClassEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :class_enrollments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :klass, null: false, foreign_key: true

      t.timestamps
    end
  end
end
