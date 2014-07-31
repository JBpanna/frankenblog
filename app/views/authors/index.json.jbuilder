json.array!(@authors) do |author|
  json.extract! author, :id, :first_name, :last_name, :email
  json.url author_url(author, format: :json)
end
