json.array!(@submissions) do |submission|
  json.extract! submission, :id, :title, :abstract, :sid, :user_id, :context_id, :revision_seq, :last_created_revision_id, :last_submitted_revision_id, :aasm_state
  json.url submission_url(submission, format: :json)
end
