array = [0, 1]
sum = 1

while sum < 100 do
  array << sum
  sum = array[-1] + array[-2]
end

puts "Array of fibonacci numbers up to 100: #{array}"