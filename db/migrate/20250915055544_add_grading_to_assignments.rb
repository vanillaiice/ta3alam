class AddGradingToAssignments < ActiveRecord::Migration[8.0]
  def change
    add_column :assignments, :max_score, :integer, null: false, default: 100
    add_column :assignments, :weight, :decimal, precision: 5, scale: 2, null: false, default: 1.0
    add_column :assignments, :score_decimal, :decimal, precision: 6, scale: 2
  end
end
