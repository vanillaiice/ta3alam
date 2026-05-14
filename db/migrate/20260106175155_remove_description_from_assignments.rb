class RemoveDescriptionFromAssignments < ActiveRecord::Migration[8.0]
  def change
    remove_column :assignments, :description, :text
  end
end
