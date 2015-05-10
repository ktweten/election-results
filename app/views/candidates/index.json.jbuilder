json.array!(@candidates) do |candidate|
  json.extract! candidate, :id, :riding_id, :name, :votes, :party_name
  json.url candidate_url(candidate, format: :json)
end
