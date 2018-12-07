json.extract! appointment, :id, :place_id, :group_id, :app_date, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
