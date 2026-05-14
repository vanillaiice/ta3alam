class CreateClassContents < ActiveRecord::Migration[8.0]
  def change
    create_table :class_contents do |t|
      t.references :klass, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :content_type

      t.timestamps
    end
  end
end
