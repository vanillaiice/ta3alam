class RenameOrganizationMembersToMembers < ActiveRecord::Migration[8.0]
  def change
    rename_table :organization_members, :members
  end
end
