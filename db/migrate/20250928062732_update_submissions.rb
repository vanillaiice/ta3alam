class UpdateSubmissions < ActiveRecord::Migration[8.0]
  def change
    add_column :submissions, :feedback, :text
    remove_column :submissions, :submitted_at, :datetime
  end
end
