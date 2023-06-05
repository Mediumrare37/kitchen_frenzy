require 'yaml'
require 'open-uri'
require 'pexels'

puts "Cleaning the db..."
Booking.destroy_all
Review.destroy_all
Kitchen.destroy_all
User.destroy_all

chef = User.create!({:email => "chef@kitchenfrenzy.com", :password => "pass123", :password_confirmation => "pass123", :first_name => "Guilherme", :last_name => "Hortinha" })
owner = User.create!({:email => "owner@kitchenfrenzy.com", :password => "pass123", :password_confirmation => "pass123", :first_name => "Fontain", :last_name => "Richardson" })
john = User.create!({:email => "john@test.com", :password => "pass123", :password_confirmation => "pass123", :first_name => "John", :last_name => "Andrews" })
paul = User.create!({:email => "paul@test.com", :password => "pass123", :password_confirmation => "pass123", :first_name => "Paul", :last_name => "Doe" })
gui = User.create!({:email => "guihortinha@test.com", :password => "pass123", :password_confirmation => "pass123", :first_name => "Lucca", :last_name => "Teruya" })

puts "Created #{User.count} users!"

# Creating multiple kitchens
addresses_url = 'https://gist.githubusercontent.com/trouni/599e03440e2552e803c54c62916f874c/raw/cc7aff8deeb27c3f22ee501b6723766a8cb68f2b/addresses.yml'
serialized_addresses = URI.open(addresses_url).read
# addresses = YAML.load(serialized_addresses)
addresses = ["913-14 Jogasawa, Mutsu shi, Aomori ken","611-3 Nikkocho, Moriguchi shi, Osaka fu","965-10 Sanjocho, Ashiya shi, Hyogo ken","996-8 Oba, Hitachiomiya shi, Ibaraki ken"]
#image counter
counter = -1
kitchen_images = ['https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166156/development/kitchen_2_cp74x7.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166156/development/kitchen_13_ajyacu.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166155/development/kitchen_9_efopwz.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166155/development/kitchen_10_k8o1gb.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166155/development/kitchen_11_dpxyfc.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166155/development/kitchen_8_ne2ulj.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166155/development/kitchen_14_npdk9o.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166154/development/kitchen_16_rfz3v0.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166154/development/kitchen_5_xq4lzn.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166154/development/kitchen_15_arzkkb.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166154/development/kitchen_6_xhixqv.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166153/development/kitchen_17_ujqgw1.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166153/development/kitchen_4_cw0lvm.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166153/development/kitchen_1_c3r3ar.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166153/development/kitchen_7_zoebsh.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166153/development/kitchen_12_muqpwf.jpg','https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685166153/development/kitchen_3_qqlnfa.jpg']

addresses.first(4).each do |address|
  new_kitchen = Kitchen.new({
    title: Faker::Restaurant.name,
    location: address,
    details: "Welcome to our stunning kitchen available for rent! Nestled in a charming neighborhood, this culinary haven is perfect for talented chefs seeking a temporary space to unleash their creativity. Step into this well-appointed kitchen and be greeted by gleaming countertops, state-of-the-art appliances, and a spacious layout that allows for seamless meal preparation. With ample storage and top-notch equipment at your fingertips, you'll have everything you need to craft culinary masterpieces. The inviting ambiance of this kitchen, combined with its modern design and meticulous attention to detail, creates an inspiring environment where gastronomic delights come to life. Whether you're a seasoned chef or an aspiring food enthusiast, this remarkable kitchen is sure to exceed your expectations and provide an ideal setting for your culinary endeavors.",
    price_per_day: rand(1..99) * 100,
    category: 'general'
    })
  counter += 1
  # file = `kitchen_#{counter}.jpg`
  # file = ActionController::Base.helpers.image_path(`kitchen_#{counter}.jpg`)
  # file = "kitchen_industrial.jpg"
  file = URI.open(kitchen_images[counter])
  # file = URI.open(`https://res.cloudinary.com/dz5qx3i5k/image/upload/v1685154936/development/kitchen_#{counter}.jpg`)
  # file = URI.open("https://www.ronenbekerman.com/wp-content/uploads/2017/02/kitchen-2-geniko-full-HD.jpg")
  new_kitchen.photo.attach(io: file, filename: "kitchen.jpg", content_type: "image/jpg")
  owner.kitchens << new_kitchen
  new_kitchen.save!
end
puts "Created #{Kitchen.count} kitchens for #{owner.first_name}!"

# Creating specific home page kitchens
4.times do
  new_kitchen = Kitchen.new({
    title: Faker::Restaurant.name,
    location: addresses.sample,
    details: "Welcome to our stunning kitchen available for rent! Nestled in a charming neighborhood, this culinary haven is perfect for talented chefs seeking a temporary space to unleash their creativity. Step into this well-appointed kitchen and be greeted by gleaming countertops, state-of-the-art appliances, and a spacious layout that allows for seamless meal preparation. With ample storage and top-notch equipment at your fingertips, you'll have everything you need to craft culinary masterpieces. The inviting ambiance of this kitchen, combined with its modern design and meticulous attention to detail, creates an inspiring environment where gastronomic delights come to life. Whether you're a seasoned chef or an aspiring food enthusiast, this remarkable kitchen is sure to exceed your expectations and provide an ideal setting for your culinary endeavors.",
    price_per_day: rand(1..99) * 100,
    category: 'recent'
    })
  counter += 1
  # file = `kitchen_#{counter}.jpg`
  file = URI.open(kitchen_images[counter])
  # file = URI.open("https://www.ronenbekerman.com/wp-content/uploads/2017/02/kitchen-2-geniko-full-HD.jpg")
  new_kitchen.photo.attach(io: file, filename: "kitchen.jpg", content_type: "image/jpg")
  owner.kitchens << new_kitchen
  new_kitchen.save!
end

puts "Created #{Kitchen.count} recently added kitchens for #{owner.first_name}!"

4.times do
  new_kitchen = Kitchen.new({
    title: Faker::Restaurant.name,
    location: addresses.sample,
    details: "Welcome to our stunning kitchen available for rent! Nestled in a charming neighborhood, this culinary haven is perfect for talented chefs seeking a temporary space to unleash their creativity. Step into this well-appointed kitchen and be greeted by gleaming countertops, state-of-the-art appliances, and a spacious layout that allows for seamless meal preparation. With ample storage and top-notch equipment at your fingertips, you'll have everything you need to craft culinary masterpieces. The inviting ambiance of this kitchen, combined with its modern design and meticulous attention to detail, creates an inspiring environment where gastronomic delights come to life. Whether you're a seasoned chef or an aspiring food enthusiast, this remarkable kitchen is sure to exceed your expectations and provide an ideal setting for your culinary endeavors.",
    price_per_day: rand(1..99) * 100,
    category: 'near'
    })
  counter += 1
  # file = `kitchen_#{counter}.jpg`
  file = URI.open(kitchen_images[counter])
  # file = URI.open("https://www.ronenbekerman.com/wp-content/uploads/2017/02/kitchen-2-geniko-full-HD.jpg")
  new_kitchen.photo.attach(io: file, filename: "kitchen.jpg", content_type: "image/jpg")
  owner.kitchens << new_kitchen
  new_kitchen.save!
end

puts "Created #{Kitchen.count} near me kitchens for #{owner.first_name}!"

4.times do
  new_kitchen = Kitchen.new({
    title: Faker::Restaurant.name,
    location: addresses.sample,
    details: "Welcome to our stunning kitchen available for rent! Nestled in a charming neighborhood, this culinary haven is perfect for talented chefs seeking a temporary space to unleash their creativity. Step into this well-appointed kitchen and be greeted by gleaming countertops, state-of-the-art appliances, and a spacious layout that allows for seamless meal preparation. With ample storage and top-notch equipment at your fingertips, you'll have everything you need to craft culinary masterpieces. The inviting ambiance of this kitchen, combined with its modern design and meticulous attention to detail, creates an inspiring environment where gastronomic delights come to life. Whether you're a seasoned chef or an aspiring food enthusiast, this remarkable kitchen is sure to exceed your expectations and provide an ideal setting for your culinary endeavors.",
    price_per_day: rand(1..99) * 100,
    category: 'industrial'
    })
  counter += 1
  # file = `kitchen_#{counter}.jpg`
  file = URI.open(kitchen_images[counter])
  # file = URI.open("https://www.ronenbekerman.com/wp-content/uploads/2017/02/kitchen-2-geniko-full-HD.jpg")
  new_kitchen.photo.attach(io: file, filename: "kitchen.jpg", content_type: "image/jpg")
  owner.kitchens << new_kitchen
  new_kitchen.save!
end

puts "Created #{Kitchen.count} industrial kitchens for #{owner.first_name}!"

# Random bookings
5.times do
  new_booking = Booking.new({
    status: Booking::STATUS.sample,
    start_date: Date.today + rand(1..10),
    end_date: Date.today + rand(11..20)
  })

  new_booking.user = chef
  new_booking.kitchen = Kitchen.all.sample
  new_booking.save!
end

# Pending bookings
2.times do
  new_booking = Booking.new({
    status: 'pending',
    start_date: Date.today + rand(30..40),
    end_date: Date.today + rand(60..80)
  })

  new_booking.user = chef
  new_booking.kitchen = Kitchen.all.sample
  new_booking.save!
end
# Past bookings
3.times do
  new_booking = Booking.new({
    status: 'past',
    start_date: Date.today + rand(-30..-20),
    end_date: Date.today + rand(-19..-1)
  })

  new_booking.user = chef
  new_booking.kitchen = Kitchen.all.sample
  new_booking.save!
end

puts "Created #{Booking.count} bookings!"

# Seed reviews
reviews = ['My experience renting this kitchen was absolutely phenomenal! As a professional chef, finding a temporary space that meets my high standards can be quite challenging, but this kitchen surpassed all expectations. The moment I walked in, I was captivated by its sleek and modern design. The countertops were spotless, and the appliances were top-of-the-line, making my cooking process seamless and efficient.','One thing that truly impressed me was the organization and ample storage available. Every utensil and tool I needed was conveniently within reach, allowing me to focus on my culinary creations without any hassle. The layout of the kitchen was well-thought-out, providing plenty of space to move around and work comfortably.','The attention to detail in this kitchen was remarkable. From the pristine cleanliness to the carefully chosen decor, it was evident that the owners take pride in maintaining a high standard. The ambiance was inviting and inspiring, creating the perfect atmosphere for culinary innovation.','Not only was the kitchen itself exceptional, but the location was also ideal. Nestled in a charming neighborhood, it offered a peaceful and quiet setting, which enhanced my concentration and creativity. Additionally, the proximity to local markets and suppliers made sourcing fresh ingredients a breeze.','Throughout my rental period, the communication and support from the hosts were outstanding. They were responsive to my inquiries and ensured that I had everything I needed to make my time in the kitchen enjoyable and productive.' ]

30.times do
  new_review = Review.new({
    content: reviews.sample
  })

  new_review.user = User.all.sample
  new_review.kitchen = Kitchen.all.sample
  new_review.save!
end

puts "Created #{Review.count} reviews!"
