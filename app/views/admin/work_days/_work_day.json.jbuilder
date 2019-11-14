json.extract! work_day, :id, :day, :arrived_at, :left_at, :created_at, :updated_at
json.url admin_user_work_day_url(user, work_day)
json.human_url admin_user_work_day_url(user, work_day.day.strftime)
