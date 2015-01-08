json.array!(@wickets) do |wicket|
  json.extract! wicket, :id, :name, :part_number, :user_id
  json.url wicket_url(wicket, format: :json)
end
