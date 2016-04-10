class AddSidToContexts < ActiveRecord::Migration
  def change
    add_column :contexts, :sid, :string
    add_index :contexts, :sid, unique: true
  end
end
