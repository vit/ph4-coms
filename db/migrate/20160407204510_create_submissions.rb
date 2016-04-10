class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :title
      t.text :abstract
      t.string :sid
      t.references :user, index: true, foreign_key: true
      t.references :context, index: true, foreign_key: true
      t.integer :revision_seq,               default: 0
      t.integer :last_created_revision_id
      t.integer :last_submitted_revision_id
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
