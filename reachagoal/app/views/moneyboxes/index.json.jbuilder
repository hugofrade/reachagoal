json.array!(@moneyboxes) do |moneybox|
  json.extract! moneybox, :id, :codenumber
  json.url moneybox_url(moneybox, format: :json)
end
