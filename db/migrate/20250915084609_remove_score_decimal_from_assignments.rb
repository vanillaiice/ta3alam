class RemoveScoreDecimalFromAssignments < ActiveRecord::Migration[8.0]
  def change
    remove_column :assignments, :score_decimal, :decimal
  end
end
