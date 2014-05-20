json.array!(@objectives) do |objective|
  json.extract! objective, :id, :name, :description, :start_day, :end_day, :price, :objective_type, :privacy
  json.url objective_url(objective, format: :json)
end
