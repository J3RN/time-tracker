json.array!(@time_entries) do |time_entry|
  json.extract! time_entry, :id, :project_id, :user_id, :task_id, :duration, :start_time, :note
  json.url time_entry_url(time_entry, format: :json)
end
