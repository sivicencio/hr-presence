json.extract! @report, :id, :start_date, :end_date, :created_at, :updated_at unless @report.blank?
json.url admin_user_report_url(@user)
json.work_days @work_days, partial: "admin/work_days/work_day", as: :work_day, user: @user
