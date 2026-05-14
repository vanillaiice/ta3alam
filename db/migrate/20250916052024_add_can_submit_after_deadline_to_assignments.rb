class AddCanSubmitAfterDeadlineToAssignments < ActiveRecord::Migration[8.0]
  def change
    add_column :assignments, :can_submit_after_deadline, :boolean
  end
end
