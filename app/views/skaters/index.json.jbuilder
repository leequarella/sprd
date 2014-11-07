json.array!(@skaters) do |skater|
  json.extract! skater, :id, :first_name, :last_name, :derby_name, :email, :vacation_days,
    :status
  json.url skater_url(skater, format: :json)
end
