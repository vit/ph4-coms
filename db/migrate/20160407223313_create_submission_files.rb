class CreateSubmissionFiles < ActiveRecord::Migration
  def change
    create_table :submission_files do |t|
      t.string :sid
      t.references :revision, index: true, foreign_key: true
      t.string :file_data
      t.string :file_type
      t.string :aasm_state

      t.timestamps null: false
    end

    add_index "submission_files", ["revision_id", "file_type"], name: "index_submission_files_revision_type", unique: true

  end
end
