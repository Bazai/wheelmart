json.array!(@mods) do |mod|
  json.extract! mod, :name, :mark_id, :model_id, :year_id
  json.url mod_url(mod, format: :json)
end
