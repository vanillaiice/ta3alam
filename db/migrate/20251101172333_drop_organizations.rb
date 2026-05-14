class DropOrganizations < ActiveRecord::Migration[8.0]
  def change
    drop_table :organizations
  end
end
