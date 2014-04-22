json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :moneybox, :photo, :place, :currency_id, :facebook_user, :twitter_user, :type
  json.url user_url(user, format: :json)
end
