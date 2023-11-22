require 'faker'
require 'open-uri'
require 'json'

# 1 - Clear existing data
# 1 - Clear existing pets from database
puts 'cleaning database...'

Pet.destroy_all
User.destroy_all

# USERS
puts 'creating users...'

# 2 - Seed users
10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.full_address,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end

puts 'finished!'

puts 'creating pets...'

# PETS
# Seed cats and dogs
dog_url = "https://dog.ceo/api/breeds/image/random/10"
dog_doc = URI.open(dog_url).read
dogs = JSON.parse(dog_doc)["message"]

cat_url = "https://api.thecatapi.com/v1/images/search?limit=10"
cat_doc = URI.open(cat_url).read
cats = JSON.parse(cat_doc).map {|cat| cat["url"]}


15.times do
  species = %w[cat dog].sample

  Pet.create(
    name: species == "dog" ? Faker::Creature::Dog.name : Faker::Creature::Cat.name,
    species: species,
    breed: species == "dog" ? Faker::Creature::Dog.breed : Faker::Creature::Cat.breed,
    age: rand(1..15),
    image_url: species == "dog" ? dogs.pop : cats.pop,
    owner_id: User.all.sample.id,
    description: Faker::Quote.famous_last_words
  )
end

puts 'finished!'
