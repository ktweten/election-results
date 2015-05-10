json.array!(@ridings) do |riding|
  json.extract! riding, :id, :name, :region
  json.url riding_url(riding, format: :json)
end
