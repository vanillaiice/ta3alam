class AddAttemptsToSubmissions < ActiveRecord::Migration[8.0]
  def change
    add_column :submissions, :attempts, :integer, default: 1
  end
end
