# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_work_days(user, date_range)
  date_range.each do |date|
    user.work_days.create(
      day: date,
      arrived_at: date + 9.hours + rand(60).minutes,
      left_at: date + 17.hours + rand(60).minutes
    )
  end
end

def create_report(user, date_range)
  user.create_report(
    start_date: date_range.last(date_range.to_a.size / 2).first,
    end_date: date_range.last
  )
end

def create_users(users_count, date_range)
  users_count.times.each do |i|
    user = User.create(
      email: "user-#{i + 1}@example.org",
      password: 'hola.123',
      name: "User #{i + 1}",
      position: "New employee"
    )
    create_work_days(user, date_range)
  end

  user = User.create(
    email: "admin@example.org",
    password: 'hola.123',
    name: "Administrator",
    role: "admin"
  )
end

date_range = 1.month.ago.to_date .. 0.days.ago.to_date

create_users(2, date_range) unless User.any?

user = User.employee.last

create_report(user, date_range) unless user.report.present?
