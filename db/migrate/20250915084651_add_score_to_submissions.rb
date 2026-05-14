class AddScoreToSubmissions < ActiveRecord::Migration[8.0]
  def change
    add_column :submissions, :score, :decimal, precision: 6, scale: 2
  end
end
