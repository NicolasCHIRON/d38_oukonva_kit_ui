require 'open-uri'
require 'uri'

User.destroy_all
Event.destroy_all
Attendance.destroy_all


# Création des utilisateurs
3.times do
  User.create(
    email: Faker::Internet.email(domain: "yopmail.com"),
    password: Faker::Internet.password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.paragraph
  )
end

User.create(
  email: "choubi@yopmail.com",
  password: "choubi",
  first_name: "choubi",
  last_name: "chouba",
  description: "c'est l'histoiiiire de la vieeeeeee",
  is_admin: true
)


puts 'Utilisateurs créés avec succès.'

# # Création des événements
50.times do
  event = Event.create(
    start_date: Faker::Time.between_dates(from: Date.today, to: Date.today + 30),
    title: Faker::Lorem.sentence,
    location: Faker::Address.full_address,
    description: Faker::Lorem.paragraph,
    price: Faker::Number.between(from: 1, to: 1000),
    duration: rand(1..100)*5,
    administrator_id: User.all.sample.id,
    )
   
    event.event_picture.attach(
      filename: 'avatar.jpg',
      io: URI.open('https://i.pravatar.cc/300')
    )


end

puts 'Événements créés avec succès.'

# Création des participations
1.times do
  Attendance.create(stripe_customer_id: Faker::Alphanumeric.alphanumeric(number: 10), attendee_id: User.all.sample.id, event_id: Event.all.sample.id)
end

puts 'Participations créées avec succès.'