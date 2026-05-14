class RemoveNotesAndFeedbackFromSubmissions < ActiveRecord::Migration[8.0]
  def change
    remove_column :submissions, :notes, :text
    remove_column :submissions, :feedback, :text
  end
end
