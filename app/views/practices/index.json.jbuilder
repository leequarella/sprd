json.array!(@practices) do |practice|
  json.extract! practice, :id, :date
  json.url practice_url(practice, format: :json)
end
