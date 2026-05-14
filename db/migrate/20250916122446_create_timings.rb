class CreateTimings < ActiveRecord::Migration[8.0]
  def change
    create_table :timings do |t|
      t.datetime :start
      t.datetime :end
      t.references :klass, null: false, foreign_key: true

      t.timestamps
    end
  end
end
