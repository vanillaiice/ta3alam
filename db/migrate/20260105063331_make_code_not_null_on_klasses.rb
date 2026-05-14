class MakeCodeNotNullOnKlasses < ActiveRecord::Migration[8.0]
  def change
    change_column_null :klasses, :code, false
  end
end
