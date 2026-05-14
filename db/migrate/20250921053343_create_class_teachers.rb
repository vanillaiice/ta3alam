class CreateClassTeachers < ActiveRecord::Migration[8.0]
  def change
    create_table :class_teachers do |t|
      t.references :klass, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
