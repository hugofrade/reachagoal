json.array!(@moneyboxes) do |moneybox|
  json.extract! moneybox, :id, :identifier
  json.url moneybox_url(moneybox, format: :json)
end
