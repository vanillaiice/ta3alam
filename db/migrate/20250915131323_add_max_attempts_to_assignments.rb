class AddMaxAttemptsToAssignments < ActiveRecord::Migration[8.0]
  def change
    add_column :assignments, :max_attempts, :integer, default: 1
  end
end
