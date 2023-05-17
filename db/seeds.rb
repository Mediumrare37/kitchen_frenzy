# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning the db..."
User.destroy_all
Kitchen.destroy_all
Booking.destroy_all

john = User.create!({:email => "john@test.com", :password => "pass123", :password_confirmation => "pass123", :first_name => "John", :last_name => "Doe" })
paul = User.create!({:email => "paul@test.com", :password => "pass123", :password_confirmation => "pass123", :first_name => "Paul", :last_name => "Doe" })

puts "Created #{User.count} users!"

require 'yaml'
require 'open-uri'

addresses_url = 'https://gist.githubusercontent.com/trouni/599e03440e2552e803c54c62916f874c/raw/cc7aff8deeb27c3f22ee501b6723766a8cb68f2b/addresses.yml'
serialized_addresses = URI.open(addresses_url).read
addresses = YAML.load(serialized_addresses)

addresses.first(10).each do |address|
  john.kitchens << Kitchen.new({
    title: "John's Kitchen",
    location: address,
    details: "Insert details here",
    price_per_day: rand(1..5) * 100
  })
end

puts "Created #{Kitchen.count} kitchens!"

5.times do
  new_booking = Booking.new({
    status: Booking::STATUS.sample,
    start_date: Date.today + 1,
    end_date: Date.today + rand(2..6)
  })


  new_booking.user = paul
  new_booking.kitchen = Kitchen.all.sample
  new_booking.save!
end

puts "Created #{Booking.count} bookings!"
