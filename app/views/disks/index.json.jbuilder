json.array!(@disks) do |disk|
  json.extract! disk, :width, :diameter_diska, :bolt_count, :bolt_distance, :et, :diameter
  json.url disk_url(disk, format: :json)
end
