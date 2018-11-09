JSON.parse(File.read('db/seeds/customers.json')).each do |raw_customer|
  # Customer.create!(customer)
  customer = Customer.new(raw_customer)
  customer.movies_checked_out_count = 0
  customer.save!

end

JSON.parse(File.read('db/seeds/movies.json')).each do |raw_movie|
  movie = Movie.new(raw_movie)
  movie.available_inventory = movie.inventory
  movie.save!
end
