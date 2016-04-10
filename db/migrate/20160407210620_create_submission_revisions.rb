class CreateSubmissionRevisions < ActiveRecord::Migration
  def change
    create_table :submission_revisions do |t|
      t.string :sid
      t.references :submission, index: true, foreign_key: true
      t.integer :revision_n,               default: 0
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
