json.array!(@brands) do |brand|
  json.extract! brand, :name, :image
  json.url brand_url(brand, format: :json)
end
