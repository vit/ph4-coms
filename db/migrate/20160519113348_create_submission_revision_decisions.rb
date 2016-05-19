class CreateSubmissionRevisionDecisions < ActiveRecord::Migration
  def change
    create_table :submission_revision_decisions do |t|
      t.string :decision
      t.text :comment
      t.references :revision, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
