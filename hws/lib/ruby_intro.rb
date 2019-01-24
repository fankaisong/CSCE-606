# When done, submit this entire file to the autograder.

# Part 1

def sum arr
  # YOUR CODE HERE
  sum = 0
  arr.each {|i| sum+=i}
  return sum
end

def max_2_sum arr
	if arr.length ==0
		return 0
	elsif arr.length ==1
		return arr[0]
		
	end
	return arr.sort.last(2)[0] + arr.sort.last(2)[1]


end

def sum_to_n? arr, n
  	# YOUR CODE HERE

  	l = arr.length - 1
	(0..l).each do |i|
		(i+1..l).each do |j|
			if arr[i]+arr[j] == n
    			return true
    		end
    	end
	end


    return false

end

# Part 2

def hello(name)
  # YOUR CODE HERE

  return 'Hello, ' + name
end

def starts_with_consonant? s
  # YOUR CODE HERE
  s = s.downcase

	if s[0]=~ /[a-z]/

		if s[0] =~ /[aeiou]/ 
			return false
		end

	elsif s==''
		return false

	else
		return false
	end

	return true

end

def binary_multiple_of_4? s
  # YOUR CODE HERE

  	for i in 0..s.length-1 do
  		if not (s[i] =~ /[0-1]/)
  			return false
  		end
  	end


	if s==''		
		return false

	elsif s.to_i(2)%4 == 0
		return true

	else 
		return false
	end
end

# Part 3

class BookInStock
# YOUR CODE HERE
  	def initialize(isbn,price)

    	if price <= 0 or isbn ==''
      		raise ArgumentError
    	end
    	@isbn = isbn
    	@price = price
  	end

	def price #getter
		@price
	end

	def isbn
		@isbn
	end


	def price=(price) #setter
		@price = price
	end



	def isbn=(isbn)
		@isbn = isbn
	end

	def price_as_string
		return "$" '%.2f' % (@price)

	end





end







