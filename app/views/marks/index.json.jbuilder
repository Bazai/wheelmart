json.array!(@marks) do |mark|
  json.extract! mark, :name
  json.url mark_url(mark, format: :json)
end
