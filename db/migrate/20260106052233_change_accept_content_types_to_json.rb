class ChangeAcceptContentTypesToJson < ActiveRecord::Migration[8.0]
  def change
    change_column :assignments, :accept_content_types, :json
  end
end
