class String
	def hamming_weight(zero=" ")
		return (self.to_a("") - [zero]).length
	end
	
	def hamming_distance(str)
		result = 0
		0.upto(self.length - 1){|i| result += 1 if self[i] != str[i] }
		return result
	end

	def to_a
		arr = Array.new
		self.each_char {|c| arr.push(c)}
		return arr
	end
end