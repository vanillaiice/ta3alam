class CreateSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :settings do |t|
      t.timestamps
      t.string :organization_name
    end
  end
end
