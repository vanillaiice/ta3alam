class ChangeAnnouncementContentNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :announcements, :content, false
  end
end
