class Display

	#Creates a string from a number
	def self.String_From_Number(number=0,tile="#",beginner="",ender="")
		return beginner+Array.new(number.round,tile).join("")+ender
	end

	#Rotates an array of strings
	def self.Rotate_String_Array(array,direction= :clockwise,spacer=" ")
		max = nil
		array.each {|item| max = item.to_s.length if max == nil || max < item.to_s.length}
		strings = Array.new
		if direction == :clockwise
			0.upto(max-1) do |y|
				s = String.new
				(array.length-1).downto(0) do |x|
					c = array[x].to_s.split("")[y]
					if c 
						s +=c
					else 
						s +=spacer
					end
				end
				strings.push(s)
			end
			return strings
		else
			(max-1).downto(0) do |y|
				s = String.new
				0.upto(array.length-1) do |x|
					c = array[x].to_s.split("")[y]
					if c 
						s +=c
					else 
						s +=spacer
					end
				end
				strings.push(s)
			end
			return strings 
		end
	end

	def self.VBar_Graph_From_Hash(count_hash,tile="#",beginner="_",ender="")
		new_hash = count_hash.map_values {|value| self.String_From_Number(value,tile,beginner,ender)}
		bars = self.Rotate_String_Array(new_hash.values,:counter_clockwise)
		names = self.Rotate_String_Array(new_hash.keys.reverse,:clockwise)
		bars.each {|value| puts value}
		names.each{|key| puts key}
		return
	end

	def self.VBar_Graph_From_Array(count_array,tile="#",beginner="_",ender="")
		if count_array.is_numeric?
			values = Array.new
			count_array.each do |item|
				values.push(self.String_From_Number(item,tile,beginner,ender))
			end
			bars = self.Rotate_String_Array(values,:counter_clockwise)
			bars.each {|value| puts value}		
		end
		return

		keys = Array.new
		values = Array.new
		count_array.each do |item|
			keys.push(item[0]);
			values.push(self.String_From_Number(item[1],tile,beginner,ender))
		end

		bars = self.Rotate_String_Array(values,:counter_clockwise)
		names = self.Rotate_String_Array(keys.reverse,:clockwise)
		
		bars.each {|value| puts value}
		names.each{|key| puts key}
		return
	end	

	#Created a horizontal bar graph from hash
	def self.HBar_Graph_From_Hash(count_hash,tile="#",beginner="|",ender="",key_size = nil)
		count_hash.each_key do |key|
			key_size = key.to_s.length if (key_size == nil) || (key.to_s.length > key_size)
		end
		count_hash.each_pair do |key,value|
			puts self.Add_Space(key,key_size)+self.String_From_Number(value,tile,beginner,ender)
		end
		return
	end

	#Create a horizontal Bar Graph from array
	def self.HBar_Graph_From_Array(count_array,tile="#",beginner="|",ender="",key_size = nil)
		if count_array.is_numeric?
			count_array.each do |key|
				puts String_From_Number(key,tile,beginner,ender)
			end	
		end
		return

		count_array.each do |key|
			key_size = key[0].to_s.length if (key_size == nil) || (key[0].to_s.length > key_size)
		end
		count_array.each do |key|
			puts self.Add_Space(key[0],key_size)+self.String_From_Number(key[1],tile,beginner,ender)
		end
		return
	end

	#Create a stem and leaf plot from hash
	def self.Stem_Leaf_From_Hash(stem_leaf_hash,seperator="|",key_size=nil)
		stem_leaf_hash.each_key do |key|
			key_size = key.to_s.length if (key_size == nil) || (key.to_s.length > key_size)
		end	 
		stem_leaf_hash.each_pair do |key,value|
			puts self.Add_Space(key.to_s,key_size)+seperator+value.sort.join(",")
		end
		return
	end

	#Convert item to string and make it at least as long as size with spacers used to fill empty space
	def self.Add_Space(item,size=0,spacer=" ")
			return item.to_s + Array.new(size - item.to_s.length,spacer).join("") if size > item.to_s.length
			return item.to_s
	end

	#Convert an array to an array of strings with equal length
	def self.Equally_Spaced_Array(array,size = nil,joiner=",")
			array.each do |item|
				size = item.to_s.length if (size == nil) || (item.to_s.length > size)
			end					 
			return array.map {|item| self.Add_Space(item,size)}.join(joiner)
	end 

	#Display a matrix with equally sized rows
	def self.Matrix(matrix,joiner="][",left="[[",right="]]",size=nil)
		joiner = joiner.to_s
		left= left.to_s
		right=right.to_s
		if !matrix.is_matrix?
			return false
		end
		matrix.each do |row|
			row.each do |item|
				size = item.to_s.length if (size == nil) || (item.to_s.length > size)
			end
		end		
		matrix.each do |row|
			puts left+self.Equally_Spaced_Array(row,size,joiner)+right
		end
			return
	end
end
