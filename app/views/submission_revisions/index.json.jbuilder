json.array!(@submission_revisions) do |submission_revision|
  json.extract! submission_revision, :id, :sid, :submission_id, :revision_n, :aasm_state
  json.url submission_revision_url(submission_revision, format: :json)
end
