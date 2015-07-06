#declare alphabets just because
$the_alphabet = "abcdefghijklmnopqrstuvwxyz"
$numerals = "0123456789"
#encryption method
def encrypt(key, phrase)
  array_crypt = $the_alphabet.split('')
  key = key - 1
  for i in 0..key
    temp1 = array_crypt[i]
    array_crypt.push(temp1)
  end
  array_crypt = array_crypt.last(26)
  new_alpha = array_crypt.join
  phrase = phrase.tr($the_alphabet, new_alpha)
  phrase = phrase.tr($the_alphabet.upcase, new_alpha.upcase)
  
  array_crypt2 = $numerals.split('')

  for i in 0..key 
  	temp2 = array_crypt2[i]
    array_crypt2.push(temp2)
  end

  array_crypt2 = array_crypt2.last(10)
  new_numerals = array_crypt2.join
  phrase = phrase.tr($numerals, new_numerals)

  return phrase
  
end

def stage2(input)
	temp1 = input.length
	rand_num1 = rand(input.length)
	rand_num2 = rand(input.length) + 1
	
	rand_num1 = rand_num1 / rand_num2

	input = input.split('')

	if rand_num1 == 0 
		return input.join('')
	else
		input.delete_at(rand_num1)
		input.push(input[rand_num2 - 1])

		return input.join('')
	end
end

def generator(input, enc_lvl)
	rand_num1 = rand(100) + 1
	rand_num3 = rand(3) + 1
	checker = 0
	pass = encrypt(rand_num1, input)

	enc_lvl -= 1 

	for i in 1..enc_lvl
		rand_num2 = rand(100) + 1
		pass = encrypt(rand_num2, pass)

		if (i % 2 == 0) && (i % 10 != 0)
			pass = pass.capitalize
		elsif i % 3 == 0
			pass = pass.swapcase
			if checker <= rand_num3
				pass = stage2(pass)
				checker += 1
			end
		elsif i % 11 == 0
			pass = pass.downcase
		end
	end

	return pass
end

def input_interpreter
	check1 = false
	until (check1 == true) do
		puts "Please insert starting string of letters and numbers, a COMMA, and then the encryption level."

		user_input = gets.chomp

		if user_input.include? ","
			check1 = true
		else
			puts "ERROR: Invalid input, use comma."
			check1 = false
		end
	end
	user_input = user_input.split(',')
	
	puts ""
	puts "* * *"
	puts ""
	
	puts generator(user_input[0], user_input[1].to_i)
end

input_interpreter