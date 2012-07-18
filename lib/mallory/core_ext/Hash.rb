class Hash

	#Returns true if a given hash has only numeric values
	def is_numeric?
		return self.values.is_numeric?
	end

	#Creates a numeric hash in which the vaues are proportional to the original values, but the add up to a specific total
	def proportion(total=nil)
			return false if !self.is_numeric?
			sum = self.values.sum;
			if total == nil
				total = 1
			end
			proportion_hash = Hash.new 
			self.each_pair {|key,value| proportion_hash[key] = value.to_f/sum * total}
			return proportion_hash
	end

	#Returns true if a given hash is a hash->permutation
	def is_permutation?
	 return self.keys.sort == self.values.sort
	end

	#Returns true of a given hash->permutation is a hash->permtation->cycle
	def is_cycle?
		if !self.is_permutation?
			return false
		end
		original_key = self.keys.first
		new_key = self[original_key]
		i=0
		while i < self.size
			if self[new_key] == original_key
				return false
			end
			i+=1
		end
		return true
	end

	#extracts a hash->permutation->cycle from a hash->permutation
	def cycle
		if !self.is_permutation?
			return false
		end
		new_cycle = Hash.new
		start_key = self.keys.first
		test_key = start_key
		while new_cycle[test_key] != start_key
			new_cycle[test_key] = self[test_key]
			test_key = self[test_key]
		end
		return new_cycle
	end

	#Remove a specific cycle from a hash
	def remove_cycle(cycle)
		hash = self.clone
		cycle.each_key do |key|
			hash.delete(key)
		end
		return hash
	end

=begin #can't change the value of self? wtf?
	def remove_cycle!(cycle)
		self = remove_cycle(cycle)
	end
=end
	#Convert a permutation hash into an array of cycles
	def cycles
	if !self.is_permutation?
		return false
	end
	new_hash = self.clone
	new_array = Array.new
	while !new_hash.empty?
		new_cycle = new_hash.cycle
		new_hash = new_hash.remove_cycle(new_cycle)
		new_array.push(new_cycle)
	end		
	return new_array
	end


	#maps values of hash
	def map_values(&block)
		hash = Hash.new
		return self if block == nil
		case block.arity
			when 0
				return self
			when 1
				self.each_pair {|key,value| hash[key] = yield(value)}
			when 2
				self.each_pair {|key,value| hash[key] = yield(key,value)}
		end
		return hash
	end

#STATIC FUNCTIONS

	#Create a permutation hash from array
	def self.Permutation_From_Array(array)
		hash = Hash.new
		return hash if array.empty?
		if array.length ==1
			hash[array[0]] = array[0]
			return false if !hash.is_permutation?
			return hash
		end
		first = 0;
		i=0
		while i<array.length
			if i == array.length-1
				hash[array[i]] = array[first]
				return hash
			end
			hash[array[i]] = array[i+1]	
			if hash.has_key? array[i+1]
			 i+=1
				first = i+1
			end
			i+=1
		end
		return hash
	end


end 