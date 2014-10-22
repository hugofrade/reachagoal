json.array!(@badges) do |badge|
  json.extract! badge, :id, :icon, :type_badge
  json.url badge_url(badge, format: :json)
end
