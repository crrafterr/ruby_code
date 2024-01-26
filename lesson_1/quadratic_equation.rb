puts "Enter coefficient a: "
a = gets.chomp.to_f
puts "Enter coefficient b: "
b = gets.chomp.to_f
puts "Enter coefficient c: "
c = gets.chomp.to_f

d = b**2 - 4*a*c

if d < 0
  puts "No roots"
elsif d > 0
  x1 = (-b + Math.sqrt(d))/2*a
  x2 = (-b - Math.sqrt(d))/2*a
  puts "Discriminant: d = #{d}; roots: x1 = #{x1}, x2 = #{x2}"
else
  x = -b/2*a
  puts "Discriminant: d = #{d}; root: x = #{x}"
end
