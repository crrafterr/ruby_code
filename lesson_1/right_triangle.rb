puts "Enter the length of the first side: "
first = gets.chomp.to_i
puts "Enter the length of the second side: "
second = gets.chomp.to_i
puts "Enter the length of the third side: "
third = gets.chomp.to_i

if (first > second && first > third) && (first**2 == second**2 + third**2)
  puts "Triangle rectangular" 
elsif (second > first && second > third) && (second**2 == first**2 + third**2)
  puts "Triangle rectangular" 
elsif (third > first && third > second) && (third**2 == first**2 + second**2)
  puts "Triangle rectangular"
elsif first == second && first == third
  puts "Triangle equilateral and isosceles"
elsif first == second || first == third || second == third
  puts "Triangle isosceles"
end