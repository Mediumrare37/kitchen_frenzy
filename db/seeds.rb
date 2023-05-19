require 'yaml'
require 'open-uri'
require 'pexels'

puts "Cleaning the db..."
User.destroy_all
Kitchen.destroy_all
Booking.destroy_all

john = User.create!({:email => "john@test.com", :password => "pass123", :password_confirmation => "pass123", :first_name => "John", :last_name => "Doe" })
paul = User.create!({:email => "paul@test.com", :password => "pass123", :password_confirmation => "pass123", :first_name => "Paul", :last_name => "Doe" })
gui_presentation = User.create!({:email => "guihortinha@test.com", :password => "pass123", :password_confirmation => "pass123", :first_name => "Guilherme", :last_name => "Hortinha" })

puts "Created #{User.count} users!"

addresses_url = 'https://gist.githubusercontent.com/trouni/599e03440e2552e803c54c62916f874c/raw/cc7aff8deeb27c3f22ee501b6723766a8cb68f2b/addresses.yml'
serialized_addresses = URI.open(addresses_url).read
# addresses = YAML.load(serialized_addresses)
addresses = ["913-14 Jogasawa, Mutsu shi, Aomori ken","611-3 Nikkocho, Moriguchi shi, Osaka fu","965-10 Sanjocho, Ashiya shi, Hyogo ken","996-8 Oba, Hitachiomiya shi, Ibaraki ken"]

addresses.first(4).each do |address|
  new_kitchen = Kitchen.new({
    title: Faker::Restaurant.name,
    location: address,
    details: "Insert details here",
    price_per_day: rand(1..99) * 100
    })
    file = URI.open("https://www.ronenbekerman.com/wp-content/uploads/2017/02/kitchen-2-geniko-full-HD.jpg")
    new_kitchen.photo.attach(io: file, filename: "kitchen.jpg", content_type: "image/jpg")
  john.kitchens << new_kitchen
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
