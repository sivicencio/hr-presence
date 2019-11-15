json.extract! user, :id, :email, :name, :position, :role, :created_at, :updated_at
json.url admin_user_url(user)
json.report_url admin_user_report_url(user) if user.report.present?
