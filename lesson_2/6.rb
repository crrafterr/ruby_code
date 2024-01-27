shopp_cart = {}
total_sum  = 0

puts "Enter stop instead of the product name to finish shopping"

loop do
  puts "Enter product: "
  product = gets.chomp
  break if product == "stop"
  puts "Enter unit price: "
  unit_price = gets.chomp.to_f
  puts "Enter quantity: "
  quantity = gets.chomp.to_f
  shopp_cart[product] = {unit_price: unit_price, quantity: quantity}
end

puts "Your shopping cart: #{shopp_cart}"

shopp_cart.each do |k, v|
  sum = v[:unit_price]*v[:quantity]
  puts "Total amount for product #{k}: #{sum}"
  total_sum += sum
end

puts "Total amount for products in shopping cart: #{total_sum}"