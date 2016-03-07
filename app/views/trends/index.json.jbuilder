json.array!(@trends) do |trend|
  json.extract! trend, :id, :group_id, :rank, :keyword
  json.url trend_url(trend, format: :json)
end
