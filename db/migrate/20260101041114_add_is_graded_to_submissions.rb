class AddIsGradedToSubmissions < ActiveRecord::Migration[8.0]
  def change
    add_column :submissions, :is_graded, :boolean
  end
end
