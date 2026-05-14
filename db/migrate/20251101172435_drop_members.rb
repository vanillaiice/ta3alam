class DropMembers < ActiveRecord::Migration[8.0]
  def change
    drop_table :members
  end
end
