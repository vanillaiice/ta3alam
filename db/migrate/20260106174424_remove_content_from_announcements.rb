class RemoveContentFromAnnouncements < ActiveRecord::Migration[8.0]
  def change
    remove_column :announcements, :content, :text
  end
end
