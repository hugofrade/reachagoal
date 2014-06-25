json.array!(@badges) do |badge|
  json.extract! badge, :id, :statement
  json.url badge_url(badge, format: :json)
end
