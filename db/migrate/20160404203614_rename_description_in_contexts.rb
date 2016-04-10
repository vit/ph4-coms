class RenameDescriptionInContexts < ActiveRecord::Migration
  def change
    rename_column :contexts, :desription, :description
  end
end
