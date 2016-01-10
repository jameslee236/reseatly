User.delete_all
Record.delete_all
Seat.delete_all

10.times do |i|
	user = User.new
	user.id = i + 1
	user.first_name = Faker::Name.first_name
	user.last_name = Faker::Name.last_name
	user.department = Faker::Name.title
	user.save
end

100.times do |i|
	record = Record.new
	record.id = i + 1
	record.user_id = rand(1..10)
	record.seat_id = rand(1..7)
	record.usage = rand(1..10)
	record.save
end

7.times do |i|
	seat = Seat.new
	seat.id = i + 1
	seat.owner_id = i + 1
	seat.save
end