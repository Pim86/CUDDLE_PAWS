puts 'cleaning database...'

Pet.destroy_all
User.destroy_all

puts 'creating users...'

User.create!(email: 'something@gmail.com', password: '123456', first_name: 'John', last_name: 'Doe', address: '1234 Main St')

puts 'finished!'

puts 'creating pets...'


Pet.create!(name: 'Fido', species: 'dog', breed: 'golden retriever', age: '3', image_url: '', owner_id:'1')
Pet.create!(name: 'Rex', species: 'dog', breed: 'german shepard', age: '5', image_url: '', owner_id:'1')

puts 'finished!'
