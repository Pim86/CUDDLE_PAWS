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
# dog_url = "https://dog.ceo/api/breeds/image/random/20"
# dog_doc = URI.open(dog_url).read
# dogs = JSON.parse(dog_doc)["message"]

dog_images = [
  "https://images.dog.ceo/breeds/mastiff-tibetan/n02108551_2836.jpg",
  "https://images.dog.ceo/breeds/maltese/n02085936_807.jpg",
  "https://images.dog.ceo/breeds/whippet/n02091134_12476.jpg",
  "https://images.dog.ceo/breeds/greyhound-italian/n02091032_5975.jpg",
  "https://images.dog.ceo/breeds/retriever-flatcoated/n02099267_4303.jpg",
  "https://images.dog.ceo/breeds/cattledog-australian/IMG_7057.jpg",
  "https://images.dog.ceo/breeds/setter-gordon/n02101006_638.jpg",
  "https://images.dog.ceo/breeds/puggle/IMG_041234.jpg",
  "https://images.dog.ceo/breeds/mastiff-tibetan/n02108551_2240.jpg",
  "https://images.dog.ceo/breeds/poodle-toy/n02113624_8880.jpg"
]

# cat_url = "https://api.thecatapi.com/v1/images/search?limit=20"
# cat_doc = URI.open(cat_url).read
# cats = JSON.parse(cat_doc).map { |cat| cat["url"] }

cat_images = [
  "https://cdn2.thecatapi.com/images/24c.jpg",
  "https://cdn2.thecatapi.com/images/34j.gif",
  "https://cdn2.thecatapi.com/images/ba4.jpg",
  "https://cdn2.thecatapi.com/images/d3a.jpg",
  "https://cdn2.thecatapi.com/images/efk.jpg",
  "https://cdn2.thecatapi.com/images/MTY1MjYzMA.jpg",
  "https://cdn2.thecatapi.com/images/BbsNPAeop.jpg",
  "https://cdn2.thecatapi.com/images/4mksJzUgG.png",
  "https://cdn2.thecatapi.com/images/VGzO6r82_.jpg",
  "https://cdn2.thecatapi.com/images/58mi0uCwO.jpg"
]

10.times do
  species = %w[cat dog].sample

  puts "Creating #{species}..."
  pet = Pet.create!(
    name: species == "dog" ? Faker::Creature::Dog.name : Faker::Creature::Cat.name,
    species: species,
    breed: species == "dog" ? Faker::Creature::Dog.breed : Faker::Creature::Cat.breed,
    age: rand(1..15),
    owner_id: User.all.sample.id,
    description: Faker::Quote.famous_last_words
  )

  image = species == "dog" ? dog_images.pop : cat_images.pop

  puts "Uploading image #{image}"
  file = URI.open(image)
  pet.image.attach(io: file, filename: "#{pet.name}.png", content_type: "image/png")
  pet.save!
end

puts 'finished!'
