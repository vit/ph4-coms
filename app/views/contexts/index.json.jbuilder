json.array!(@contexts) do |context|
  json.extract! context, :id, :title, :desription, :slug, :type, :user_id
  json.url context_url(context, format: :json)
end
