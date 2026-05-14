class AddModuleNameToClassContent < ActiveRecord::Migration[8.0]
  def change
    add_column :class_contents, :module_name, :string
  end
end
