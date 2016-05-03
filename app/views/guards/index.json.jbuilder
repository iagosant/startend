json.array!(@guards) do |guard|
  json.extract! guard, :id, :first_name, :last_name
  json.url guard_url(guard, format: :json)
end
