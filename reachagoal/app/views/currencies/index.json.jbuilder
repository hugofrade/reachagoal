json.array!(@currencies) do |currency|
  json.extract! currency, :id, :name, :symbol
  json.url currency_url(currency, format: :json)
end
