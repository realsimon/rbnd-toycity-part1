require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date
puts Time.new

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "

# For each product in the data set:
products_hash["items"].each do |toy|

  # Print the name of the toy
  puts toy["title"]

  # Print the retail price of the toy
  puts "Retail price: #{toy["full-price"]}"

  # Calculate and print the total number of purchases
  sales_num = toy["purchases"].count
  puts "Number sold: #{sales_num}"

  # Calculate and print the total amount of sales
  sales = toy["purchases"].map {|purchase| purchase["price"]}

  #puts "#{sales}"
  sales_sum = sales.reduce(:+)
  puts "Total amount of sales: #{sales_sum}"

  # Calculate and print the average price the toy sold for
  puts "Average sale price: #{sales_sum / sales_num}"

  # Calculate and print the average discount (% or $) based off the average sales price
  puts "Average discount: #{((1 - ((sales_sum / sales_num) / toy["full-price"].to_f)) * 100).round(2)} %"
  puts
end

	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# For each brand in the data set:
brands = (products_hash["items"].map {|toy| toy["brand"]}).uniq
brands.each do |brand|

  # Print the name of the brand
  puts "Brand: \"#{brand}\""

  # Count and print the number of the brand's toys we stock
  brand_toys = products_hash["items"].select {|toy| toy["brand"] == brand}
  puts "#{brand} inventory: #{(brand_toys.map {|toy| toy["stock"]}).reduce(:+)}"

  # Calculate and print the average price of the brand's toys
  puts "Average price for #{brand}: #{((brand_toys.map {|toy| toy["full-price"].to_f}).reduce(:+) / brand_toys.count).round(2) }"

  # Calculate and print the total revenue of all the brand's toy sales combined
  revenue = 0.0
  brand_toys.each do |toy|
      revenue = revenue + (toy["purchases"].map {|purchase| purchase["price"]}).reduce(:+) + (toy["purchases"].map {|purchase| purchase["shipping"]}).reduce(:+)
  end
  puts "#{brand} revenue: #{revenue.round(2)}"
  puts
end
