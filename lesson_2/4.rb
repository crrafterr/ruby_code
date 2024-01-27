vowel = {}
alphabet = ('a'..'z').to_a

alphabet.map{|i| vowel[i] = alphabet.index(i)+1 if i =~ /[aeiouy]/ }

puts "Hash of vowel letters: #{vowel}"