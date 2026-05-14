class CreateKlasses < ActiveRecord::Migration[8.0]
  def change
    create_table :klasses do |t|
      t.string :code
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
