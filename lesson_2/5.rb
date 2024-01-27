puts "Enter day: "
day = gets.chomp.to_i
puts "Enter month: "
month = gets.chomp.to_i
puts "Enter year: "
year = gets.chomp.to_i
date_namber = 0
day_of_month = {1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31}

day_of_month[2] = 29 if (year%4 == 0 && year%100 != 0) || (year%400) == 0
day_of_month.each do |m, d|
  if m < month
    date_namber += d
  elsif m == month
    date_namber += day
  else
    break
  end
end

puts "Number of date from the beginning of the year: #{date_namber}"
