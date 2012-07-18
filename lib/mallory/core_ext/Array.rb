class Array

	# Returns a hash where each key is a unique element in the array and each value is the number of occurences or each key
	#
	# ==== Attributes
	#
	# ==== Examples
	#
	# * [1,2,3].counts #Outputs: {1=>1, 2=>1, 3=>1}
	# * [1,2,2,3,3,3].counts #Outputs: 1=>1, 2=>2, 3=>3}
	def counts
		has = Hash.new
		self.each {|x| has[x] = self.count(x)}
		return has
	end

	# Returns a hash where each key is a unique element in the array and each value is the number of occurences or each key
	#
	# ==== Attributes
	#
	# ==== Examples
	#
	# * [1,2.0,Rational(3)].numeric? #Outputs: true
	# * [1,2,"three"].numeric? #Outputs: false
	def numeric?
		return all? {|x| Math.Is_Numeric?(x)}
	end
	
	alias is_numeric? numeric?

	def most
		counts = self.counts.values.max
	end

	def power_set
		arr = Array.new
		0.upto(length){|size| arr.concat(self.combination(size).to_a)}
		return arr
	end
	
	# Returns an array containing most frequently occuring elements ("modes") of an array.
	#
	# ==== Attributes
	#
	# ==== Examples
	#
	# * [1,2,2,4].modes #Outputs: [2]
	# * ["two",4,"two", 4].modes #Outputs: ["two",4]
	# * [1,2,2,3,2,3,3,3].modes #Outputs :[3]
	def modes
		modes_array = Array.new
		most = self.most
		counts = self.counts
		counts.each_pair do |key,value|
			if value == most
				modes_array.push(key)
			end
		end
		return modes_array
	 end 

	# Returns the first of the most frequently occuring elements in an array. Warning: 
	#
	# ==== Attributes
	#
	# ==== Notes
	#
	# * Warning: if there are multiple elements that occur with the same frequency, only one will be returned and the rest will be ignored.
	#
	# ==== Examples
	#
	# * [1,2,2,4].mode #Outputs: 2
	# * ["two",4,"two", 4].mode #Outputs: "two"
	# * [1,2,2,3,2,3,3,3].mode #Outputs : 3 
	def mode
		return self.modes[0]
	end
	
	# Returns the middle element of a numeric array if it were to be ordered.  
	#
	# ==== Attributes
	#
	# ==== Notes
	#
	# * Returns false if array is not numeric
	# * If the array contains an even number of elements, this function returns the mean of the two middle elements.
	#
	# ==== Examples
	#
	# * [5,4,1,2,3].median #Outputs: 3
	# * [5,4,1,6,2,3].median #Outputs: 3.5
	def median
		if !self.numeric?
			return false
		end
		nums = self.sort
		
		if nums.length.odd?
			return nums[(nums.length/2).to_i]
		end
		return (nums[nums.length/2] + nums[nums.length/2 -1]).to_f/2
	end 

	#Collapses an array with the given binary opperationoperation
	#
	# ==== Attributes
	#
	# * +binopp+ - A process with an arity of two that returns a single element.
	# ==== Notes
	#
	#
	# ==== Examples
	#
	# * [1,2,3].collapse(->(a,b){a+b}) #Outputs: ((1+2)+3) = (3+3) = 6
	# * ["hey","there","bud"].collapse(->(a,b){a+b}) #Outputs "heytherebud"
	def collapse(binopp)
			return self.inject {|memo,n| binopp.call(memo,n)}
	end	
	
	#Returns the sum of all elements in an array
	#
	# ==== Attributes
	#
	# ==== Notes
	#
	# * Returns false if array is not numeric
	# * Returns 0 if array is empty
	# ==== Examples
	# * [1,2,3,4].element_sum  #Outputs: 4
	# * [4.2,5.5,3].element_sum #Outputs: 12.7
	def element_sum
		if !self.numeric?
			return false
		end
		return self.inject(0) {|memo,n| memo + n}	
	end
	
	#Returns the product of all elements in an array
	#
	# ==== Attributes
	#
	# ==== Notes
	# * Returns false if array is not numeric
	# * Returns 1 if array is empty
	# ==== Examples
	# * [1,2,3,4].element_product  #Outputs: 24
	# * [4.2,5.5,3].element_product #Outputs: 69.3
	def element_product
		if !self.numeric?
			return false
		end
		return self.inject(1) {|memo,n| memo * n}	
	end
	
	alias cross_product product
	
	# Returns the mean (or "average") of all elements in an array.
	#
	# ==== Attributes
	#
	# ==== Notes
	#
	#
	# ==== Examples
	#
	def mean
		return false if !self.numeric?
		return self.element_sum.to_f/self.length
	end
	alias average mean
	
	def central_moment(k=1)
		self.map{|x| (x - self.mean)**k}.mean
	end
	
	
	#Returns the variance of all elements in a numeric array.
	#
	# ==== Attributes
	#
	# ==== Notes
	#
	#
	# ==== Examples
	#
		def variance(bias=:unbiased)
			return false if !self.numeric?
			return central_moment(2) * Float(length)/(length - 1) if (bias == :unbiased)
			return central_moment(2) 
		end

	#Returns the standard deviation of all elements in a numeric array.
	#
	# ==== Attributes
	#
	# ==== Notes
	#
	#
	# ==== Examples
	#
		def standard_deviation(bias=:unbiased)
			if !self.numeric?
				return false
			end
			return Math.sqrt(self.variance(bias))
		end
		
	
	#Returns a stem and leaf hash where the stems are defined by the given array of ordered buckets
	#
	# ==== Attributes
	#
	# ==== Notes
	#
	#
	# ==== Examples
	#
	def stem_leaf(stems)
		if !self.numeric? || !stems.numeric?
			return false
		end
		plot_hash = Hash.new
		stems.sort!
		stems.each do |key|
			plot_hash[key] = Array.new
		end
		i=0
		while i < stems.length
			lower = stems[i]
			higher = nil
			if stems[i+1]
				higher = stems[i+1]
			end
			
			self.each do |item|
				if (lower <=item && higher == nil) || (lower <= item && item < higher) 
					plot_hash[stems[i]].push(item)
				end
			end
			i +=1
		end
		return plot_hash
	end


	def percentile(percent=0.5)
		ordered = self.sort
		position = percent*(ordered.length() -1);
		if position == position.to_i
			return ordered[position.to_i]
		end
		diff = position - position.to_i
		lower = position.to_i
		higher = position.to_i + 1

		if diff > 0.5
			return ordered[lower].to_f*(1-diff) + ordered[higher].to_f*diff
		end 
			return ordered[lower].to_f*(diff) + ordered[higher].to_f*(1-diff) 
	end
	
	def summary(numbers=5)
		time = 0.0
		summary_array = Array.new
		numbers.times do
			summary_array.push(self.percentile(time/(numbers-1)))
			time +=1
		end
		return summary_array
	end

	def matrix?(row_size = nil)
		return all? {|x| x.class == Array && x.length == self[0].length}
	end
	
	alias is_matrix? matrix?
	
	
	def height
		return false if !self.matrix?
		return self.length
	end
	
	def width
		return false if !self.matrix?
		return 0 if self.empty?
		return self[0].length
	end	

	def is_flat?
		self.each{|x| return false if x.class == Array}
		return true
	end

	def is_multi_dimensional?
		self.each{|x| return false if x.class != Array}
		return true
	end
	
	#I'm not sure why I made this and the only useful things I can think of what might be useful seem like they would cause infinite loops
	def transform_end_nodes(operation,criterion=nil)
		criterion = ->(a){a.class != Array} if(criterion == nil)
		
		newarray = self.map do |x|
			if(criterion.call(x))
				operation.call(x)
			else 
				x.transform_end_nodes(operation,criterion)
			end
		end
		return newarray
	end
	
	def fractalize(depth=1)
		a = self.clone
		0.upto(depth-1) do 
			a = a.transform_end_nodes(->(x){a.clone})
		end
		return a
	end
	
	def insert_at(inserted,index=0)
		return self + inserted if(index == self.length)
		a = self.clone
		
		first = a.slice((0...index))
		last = a.slice((index..a.length))
		return first + inserted + last
	end

	def remove_at(index=0)
		a = self.clone
		first = a.slice((0...index))
		last = a.slice((index+1...a.length))
		return first + last
	end
	
	def combine(a,operation,mismtach = :stop,default = nil)
		length = Array.Longer(a,self).length-1;
		result = Array.new
		0.upto(length) do |i|
			if(i <self.length && i < a.length)
				result.push(operation.call(self[i],a[i]))
			else
				case mismtach
				when :fail then return []
				when :stop then return result
				when :overflow then
					if(i >= self.length)
						result.push(a[i])
					elsif(i >= a.length)
						result.push(self[i])
					end
				else result.push(default)
				end
			end
		end
		return result
	end

	def collapse(operation)
		return nil if self.length == 0
		s = self.clone
		while (s.length >1)
			s[s.length-2] = operation.call(s[s.length-2],s[s.length-1])
			s.pop
		end
		return s[0] if self.length
	end

	
	#STATIC FUNCTIONS

	def self.Longer(a,b)
		return a if (a.length > b.length)
		return b
	end
	
	def self.Shorter(a,b)
		return a if (a.length <= b.length)
		return b
	end

	def self.Wrap(a,depth=1)
			return a if (depth == 0)
			newArray = [a]
			newArray = Wrap(newArray,depth-1);
			return newArray;
	end

	
	
	
	def self.Arithmetic(seed=0,incriment=1,lim_type=:length,limit=100)
		sequence = Array.new
		
		while (true)
			case lim_type
				when :max then break if (seed > limit)
				when :min then break if (seed < limit)
				else
					break if (sequence.length == limit)
			end
			sequence.push(seed)
			seed +=incriment
		end
		return sequence
	end

	def self.Arithmetic_Bounds(lower=0,upper=100,intervals=1)
			incriment = (upper - lower)
			incriment = incriment.to_f if (Math.Is_Numeric?(incriment,Integer))
			incriment = incriment/intervals
			return Arithmetic(lower,incriment,lim_type=:max,upper)
	end


	def self.Geometric(seed=1,incriment=2,length=10,max=nil,min=nil)
		sequence = Array.new
		
		length.times do 
			break if(min !=nil && seed < min)
			break if(max !=nil && seed > max)
			sequence.push(seed)
			seed *=incriment
		end
		return sequence
	end
	
	def self.Range(start,finish,opt = :inclusive)
		case opt
			when :exclusive then return (start - finish < 0) ? (start+1...finish).to_a : (start-1...finish).to_a
			when :left then return (start...finish).to_a
			when :right then return(start - finish < 0) ? (start+1..finish).to_a : (start-1..finish).to_a
			else return (start..finish).to_a
		end
	end

	def last=(item)
		self[length-1] = item
	end
	
	def self.ConsecutiveMatches(arr,criterion)
		appearences = Array.new(1,nil)
		arr.each do |x|
			if(criterion.call(x))
				appearences.last = 0 if appearences.last == nil
				appearences.last += 1
			else
				appearences.push(nil)
			end
		end
			return appearences.compact
	end

	def self.Recursive(formula=lambda{|a,b| a+b},length=10,*seeds)
		sequence = Array.new
		values = Array.new
		seeds.each do |seed|
			values.push(seed)
			sequence.push(seed)
		end
		length.times do
			sequence.push(formula.call(*values))
			i=0
			while i < values.length
				if i < values.length-1
					values[i] = values[i+1] 
				else
					values[i] = sequence.last
				end
				i+=1
			end		
		end
			return sequence
	end

	def self.Make_Matrix(width,height,init=nil)
		matrix = Array.new
		0.upto(height.floor-1) {matrix.push(Array.new(width.floor,init))}
		return matrix
	end
	
	def self.Make_Identity_Matrix(width,height=nil)
		height = width if (height == nil)
		matrix = self.Make_Matrix(width,height,0)
		0.upto(width - 1) do |i|
			0.upto(height - 1) do |j|
				matrix[i][j] = 1 if (i == j)
			end
		end
		return matrix
	end
	
	def self.Make_Counted_Matrix(width,height=nil,start=0)
		height = width if (height == nil)
		matrix = self.Make_Matrix(width,height)
		0.upto(width - 1) do |i|
			0.upto(height - 1) do |j|
				matrix[i][j] = start
				start += 1
			end
		end
		return matrix
	end
	
	def fill_by_index!(opperation=->(i,j){nil})
		0.upto(self.width - 1) do |i|
			0.upto(self.height - 1) do |j|
				self[i][j] = opperation.call(i,j)
			end
		end
	end
	
	def row (index=0)
		return [self[index]]
	end
	
	def col (index=0)
		return transpose.row(index).transpose
	end
	
	def remove_row(index=0)
		return remove_at(index)
	end
	
	def remove_col(index=0)
		return transpose.remove_row(index).transpose
	end
	
	def insert_row(arr,index=0)
		return insert_at([arr],index)
	end
	
	def insert_col(arr,index=0)
		return transpose.insert_row(arr,index).transpose
	end
	
	def merge(arr)
		arr = [arr] if arr.class != Array
		return self + arr
	end
	
	def merge_rows(arr)
		return false if (width != arr.width)
		return self.merge(arr)
	end
	
	def merge_cols(arr)
		return false if (height != arr.height)
		return transpose.merge(arr.transpose).transpose
	end
	
	def set_row(arr,index=0)
		return false if(width != arr.length)
		a = self.clone
		a[index] = arr
		return a
	end
	
	def set_col(arr,index=0)
		return false if(height != arr.length)
		a = transpose
		a[index] = arr
		return a.transpose
	end
	
	def absorb(block,i2=0,j2=0)
		target = self.clone
		0.upto(block.width - 1) do |i|
			0.upto(block.height - 1) do |j|
				if(i+i2 < target.width && j+j2 < target.height)
					target[i+i2][j+j2] = block[i][j]
				end
			end
		end
		return target
	end
	
	#
	#
	# ==== Attributes
	#
	# ==== Notes
	# * I had in my notes earlier that this MIGHT be simplified using the place blocks functions, but upon re-implementing this, i'm nos so sure...
	#
	# ==== Examples
	#
	def break_blocks
		new_height = 0
		new_width = 0
		
		0.upto(height - 1) do |x|
			new_height += self[x][0].height
		end
		0.upto(width - 1) do |x|
			new_width += self[0][x].width
		end

		matrix = Array.Make_Matrix(new_width,new_height)
		current_height = 0
		current_width = 0
		while current_height < new_height
			i = 0
			while i < height 
				j = 0
				while j < width
					current_matrix = self[i][j]
					i2 = 0
					while i2 < current_matrix.height 
						j2 = 0
						while j2 < current_matrix.width
							matrix[current_height + i2][current_width + j2] = current_matrix[i2][j2]
							j2 += 1
						end
						i2 += 1
					end
					current_width += current_matrix.width
					j += 1
				end
				current_width =0
				current_height += current_matrix.height
				i+=1
			end
		end
		return matrix
	end
	
	#
	# ==== Attributes
	#
	# ==== Notes
	#
	#
	# ==== Examples
	#
	def pad(element=nil,rows=true,cols=true,top=true,bottom=true,left=true,right=true)
		matrix = self.clone
		insert_count = 0
		
		if (rows)
			insert_count = 1
			padding_array = Array.new(matrix.width, element)
			while (insert_count < matrix.height)
				matrix = matrix.insert_row(padding_array,insert_count)
				insert_count += 2
			end
		end
		
		if (cols)
			insert_count = 1
			padding_array = Array.new(matrix.height, element)
			while (insert_count < matrix.width)
				matrix = matrix.insert_col(padding_array,insert_count)
				insert_count += 2
			end
		end
		

		if(top)
			padding_array = Array.new(matrix.width, element)
			matrix = matrix.insert_row(padding_array,0)
		end
		
		if(bottom)
			padding_array = Array.new(matrix.width, element)
			matrix = matrix.insert_row(padding_array,matrix.height)
		end
		
		if(left)
			padding_array = Array.new(matrix.height, element)
			matrix = matrix.insert_col(padding_array,0)
		end
		
		if(right)
			padding_array = Array.new(matrix.height, element)
			matrix = matrix.insert_col(padding_array,matrix.width)
		end

		return matrix
	end
	
	#
	# ==== Attributes
	#
	# ==== Notes
	#
	#
	# ==== Examples
	#
	def diagnoal(offset=0)
		diag = Array.new()
		
		if(offset >= 0)
			0.upto(width - 1 - offset) {|i| diag.push(self[i][i+offset])}
		else
			offset = -offset
			0.upto(height - 1 - offset) {|i| diag.push(self[i+offset][i])}
		end
	
		return diag
	end
	
	#
	# ==== Attributes
	#
	# ==== Notes
	#
	#
	# ==== Examples
	#
	def minor_diagnoal(offset=0)
		diag = Array.new()
		if(offset >= 0)
			0.upto(height-1-offset) {|i| diag.push(self[i][width-1-offset-i])}
		else
			offset = -offset
			offset.upto(height-1) {|i| diag.push(self[i][width-i+offset-1])}

		end
	
		return diag
	end
	
	#Returns the number of rows in a matrix
	def rows
		return self.length if(self.matrix?)
	end
	
	#Returns the number of columns in a matrix
	def cols
		return self[0].length if(self.matrix? && self.length>0)
	end
	
	
	
	#
	# ==== Attributes
	#
	# ==== Notes
	#
	#
	# ==== Examples
	#
	def display(joiner="][",left="[[",right="]]",size=nil)
		Display.Matrix(self,joiner,left,right,size)
	end
	alias show display
	
	def self.Benford(base = 10, place = 0)
		has = Hash.new
		1.upto(base - 1){|x| has[x] = Benford_Digit(x,base,place)}
		return has
	end
	
	#
	# ==== Attributes
	#
	# ==== Notes
	#
	#
	# ==== Examples
	#
	def self.Benford_Digit(digit=1,base=10,place=0)
		lower = (base**(place-1)).to_i
		higher = ((base**(place))-1).to_i
		return (lower..higher).to_a.map{|k| Math.log(1+1.0/(base*k+digit),base)}.element_sum
	end
	
	#Provides rough estimate of the magnitudes spanned. Not entirely accurate.
	#
	# ==== Attributes
	#
	# ==== Notes
	# *Not Entirely accurate. For eample, Math.log(1000,10) should equal 3. Instead, ruby returns 2.9...
	#
	# ==== Examples
	# 
	def magnitudes_spanned(base = 10)
		return self.map {|x| Math.log(x,base).round}.uniq
	end
	
	
	#Returns true if a distribution spans more than one magnitude
	# ==== Attributes
	#
	# ==== Notes
	# * See "spans_magnitued" for notes on accuracy
	#
	# ==== Examples
	#
	def spans_magnitudes?(base = 10)
		return magnitudes_spanned.length > 1
	end

	#
	# ==== Attributes
	#
	# ==== Notes
	#
	#
	# ==== Examples
	#
	def digit_frequency(base=10,place=0,zero_count=true)
		counts = self.map {|x| x.to_a[place]}.counts
		final = Hash.new
		1.upto(base - 1){|d| final[d] = 0} if zero_count
		counts.map {|key,value| final[key] = value.to_f/counts.values.element_sum}

		return final
	end

	#
	# ==== Attributes
	#
	# ==== Notes
	#
	#
	# ==== Examples
	#
	def benford_deviation(base = 10, place = 0)
		freq = digit_frequency(base, place, true)
		bfreq = Array.Benford(base, place)
		sum = 0
		1.upto(base - 1){|d| sum += (freq[d] - bfreq[d]).abs}
		return sum
	end

	@col_labels
	@row_labels
	
	def col_labels=(labels)
		labels = labels.uniq
		@col_labels = labels if labels.length == cols
		#throw error
	end
	
	def col_labels
		return (0...cols).to_a if !@col_labels
		return @col_labels
	end
	
	def col_label(name)
		return col(col_labels.index(name)) if col_labels.index(name)
		return nil
	end
	
	def row_labels=(labels)
		labels = labels.uniq
		@row_labels = labels if labels.length == rows
		#throw error
	end
	
	def row_labels
		return (0...rows).to_a if !@row_labels
		return @row_labels
	end
	
	def row_label(name)
		return row(row_labels.index(name)) if row_labels.index(name)
		return nil
	end

end

	#
	# ==== Attributes
	#
	# ==== Notes
	#
	#
	# ==== Examples
	#
