# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

first_name = Faker::Name.first_name
last_name = Faker::Name.last_name
department = Faker::Name.title




User.delete_all
Record.delete_all
Seat.delete_all

10.times do |i|
	user = User.new
	user.id = i
	user.first_name = first_name
	user.last_name = last_name
	user.department = department
	user.save
end

100.times do |i|
	record = Record.new
	record.id = i
	record.user_id = rand(1..10)
	record.seat_id = rand(1..7)
	record.usage = rand(1..10)
	record.save
end

7.times do |i|
	seat = Seat.new
	seat.id = i
	seat.save
end