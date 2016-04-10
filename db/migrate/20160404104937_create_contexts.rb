class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.string :title
      t.text :desription
      t.string :slug
      t.string :type
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :contexts, :slug, unique: true
  end
end
