json.array!(@personal_records) do |personal_record|
  json.extract! personal_record, :person_id, :event_type, :hour, :min, :sec, :event_name
  json.url personal_record_url(personal_record, format: :json)
end
