puts "Enter your name: "
name = gets.chomp
puts "Enter your height: "
height = gets.chomp

weight = (height.to_i - 110) * 1.15

puts "#{name}, your ideal weight - #{weight}"
puts "Your weight is already optimal" if weight < 0
