json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :moneybox, :photo, :place, :currency_id, :ffacebook_user, :twitter_user
  json.url user_url(user, format: :json)
end
