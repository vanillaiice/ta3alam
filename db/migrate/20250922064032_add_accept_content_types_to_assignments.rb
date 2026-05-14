class AddAcceptContentTypesToAssignments < ActiveRecord::Migration[8.0]
  def change
    add_column :assignments, :accept_content_types, :text
  end
end
