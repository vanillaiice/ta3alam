class CreateModules < ActiveRecord::Migration[8.0]
  def change
    create_table :modules do |t|
      t.string :name
      t.references :klass, null: false, foreign_key: true

      t.timestamps
    end
  end
end
