JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |raw_movie|
  movie = Movie.new(raw_movie)
  movie.available_inventory = movie.inventory
  movie.save!
end
