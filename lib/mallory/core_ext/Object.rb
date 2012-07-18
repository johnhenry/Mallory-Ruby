class Object
	def hash_on(properties={})
		return hash if properties.empty? 
		hash_array = Array.new
		#Bug!!! Inconsistent hash order for Ruby version < 1.9
		properties.each do |property,evaluate|
			begin
				if evaluate == nil
					hash_array.push send property.to_sym
				else
					hash_array.push evaluate.call send property.to_sym
				end
			rescue => e
				hash_array.push e
			end
		end
		return hash_array.hash
	end

	def chain_send(message,times=1)
		a = self
		while(times > 0)
			a = a.send(message)
			times = times - 1
		end
		return a
	end
end
