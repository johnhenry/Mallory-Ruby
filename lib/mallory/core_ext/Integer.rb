class Integer
	#Returns a number's factorial
	def factorial
		return 1 if self == 0
		return self*(self -1).factorial
	end
	#Returns a number's factorial (Alternate Version)
	alias _! factorial

	def primorial
		return self.primes_to.element_product
	end
	
	def primes_downto(start=2)
		return[] if self < 2
		primes = Array.new
		self.downto(start){|x| primes.push(x) if x.prime?}
		return primes
	end
	
	def primes_upto(limit)
		primes = Array.new
		self.upto(limit){|x| primes.push(x) if x.prime?}
		return primes
	end

	def permutation(r)
		return self._!/(self-r)._!
	end
	
	def combination(r)
		return self.permutation(r)/r._!
	end

	#Returns true iff a number is odd.
	def odd?
		return self % 2 ==1
	end
	
	#Returns true iff a number is odd
	def even?
		return self % 2 ==0
	end

	#Returns an array of a Integer's proper factors
	def proper_factors
		factor_array = Array.new
		1.upto(self) do |num|
			if self % num == 0
				factor_array.push(num)
			end
		end
		return factor_array - [self]
	end
	#Returns an array of all of a Integer's factors
	def factors
		return proper_factors | [self]
	end

	#Returns true iff a Integer is prime
	def prime?
		return proper_factors.length ==1
	end

	def almost_prime?(k=1)
		return prime_decomposition.values.element_sum == k
	end

	def modular_set
		arr = Array.new
		0.upto(self -1){|n| arr.push n}
		return arr
	end

	def multiplicative_group
		return modular_set.select{|n| n.coprime? self}
	end
	
	#results don't agree with wikipedia
	def carmichael
		g = multiplicative_group
		puts g.to_s
		1.upto(self-1) do |m|
			g.map! {|n| (n ** m) % self}
			puts g.to_s
			ready = true
			g.each {|n| ready = false if n != 1}
			return m if ready
		end
	end

	def multiplicative_inverse_mod(n)
		1.upto(n-1){|x| return x if ((self*x) % n) == 1}
		return nil
	end

	def additive_inverse_mod(n)
		0.upto(n-1){|x| return x if ((self+x) % n) == 0}
		return nil
	end


	def coprime?(k)
		return self.gcd(k) == 1
		#return (self.factors & k.factors) == [1]
	end
	
	#Returns true iff a Integer is composite
	def composite?
		return proper_factors.length !=1 && self != 1
	end

	#Returns an array of all of a given number's prime factors
	def prime_factors
		return factors.find_all {|num| num.prime?}
	end

	#Returns a hash that represents a given number's prime decompositon in which the keys are the prime factors and the values are the exponents of the factors
	def prime_decomposition
		prime_hash = Hash.new
		return prime_hash if self == 1
		if self.prime?
			prime_hash[self] = 1
			return prime_hash
		end
		prime_factors.each do |num|
			prime_hash[num] = 0
			testnum = num
			while self % testnum == 0
					prime_hash[num] +=1
					testnum *= num
			end
		end	
		return prime_hash
	end

	def prime_power?
		return prime_decomposition.size == 1
	end
	
	def abundance
		return self.proper_factors.element_sum - self
	end
	
	def defficiency
		return -self.abundance
	end
	
	def perfect?
		return self.abundance == 0
	end
	
	def amicable?(num)
		return self.proper_factors.element_sum == num && num.proper_factors.element_sum == self
	end
	
	def smooth?(b)
		self.prime_factors.each{|x| return false if (x > b)}
		return true
	end

	def power_smooth?(b)
		self.prime_powers.each{|x| return false if (x > b)}
		return true
	end
	
	def prime_powers
		powers = Array.new
		self.prime_decomposition.each {|key,value| powers.push(key**value)}
		return powers
	end
	
	def totient
		return self -1 if (self.prime?)
		return Integer(self*self.prime_factors.map{|x| 1 - 1.0/x}.element_product)
	end
	
	def radical
		return self.prime_factors.element_product
	end
	
	def divisor(x=1)
		self.factors.map{|n| n**x}.element_sum
	end
	
	def big_omega
		return prime_decomposition.values.element_sum
	end
	
	def omega
		return prime_factors.length
	end

	def liouville
		return (-1)**self.big_omega
	end
	
	def mobius
		return (-1)**self.omega if (self.omega == self.big_omega)
		return 0
	end
	
	def square_free?
		return prime_decomposition.values.select{|x| x>1}.empty?
	end
	
	def self.Sociable(*list)
		sums = list.map {|x| x.proper_factors.element_sum}
		matches = 0;
		list.each{|x| matches +=1 if (sums.include?(x))}
		return true if(matches == list.length)
		return false
	end
	
	
	#Random
	def rand_int(limit=0,include_max=false)
		min = [self,limit].min
		max = [self,limit].max
		max = max + 1 if (include_max)
		return min+rand(max - min)
		
	end
	
	#Digit Manipulation


	
	def to_a(base=10)
		return self.to_s(base).chars.to_a.map {|x| x.to_i}
	end

	#Note: hash#.inject should take three values - memo, index, value
	def self.From_Array(arr,base=10)
		num = 0
		arr.each_index {|index| num += arr[arr.length - index-1] * (base**index) }
		num
	end

	def places(base=10)
		has = Hash.new
		arr = to_a(base)
		(arr.length-1).downto(0) {|index| has[index] = arr[arr.length - index-1] }
		return has
	end
	
	def expand(base = 10)
		has = places(base)
		string = ""
		has.each {|key,value| string +=  value.to_s + "*" + (base**key).to_s + "+" if (key!=0)}
		string += has[0].to_s + "*1"
		return string
	end
	
	def expand2(base = 10)
		has = places(base)
		string = ""
		has.each {|key,value| string += (value*base**key).to_s + "+" if (key!=0)}
		string += has[0].to_s
		return string
	end

	#I think there's a BUG in the base change code (specifically, i think it's from the "to_a" method
	#Also, i need to add some more stuff here specifically dealing with bases greater than 10 that use letters (that is "a" in base 16 is "10" in base 10
	#Note, hash#.inject should take three values - memo, key, value
	def from_base_10_to(starting_base=10)
		has=places(starting_base)
		num = 0
		has.each{|key,value| num += (value*(10**key))}
		return num
	end
	
	def to_base_10_from(starting_base=10)
		has = places
		num = 0
		has.each{|key,value| num += (value*(starting_base**key))}
		return num
	end
	

	def to_base(ending=10,starting=10)
		return self.to_base_10_from(starting).from_base_10_to(ending)
	end

#Unorganized
	def digit_sum
		return self.to_a.element_sum
	end


	def method_missing(meth,*args,&block)
		methods = [:prime?]
		meth_string = meth.to_s
		methods.each do |method|
			if(meth_string.end_with?("_"+method.to_s))
				submethod = meth_string.rpartition("_")[0].concat("?").to_sym
				return send(submethod) && send(method) if (respond_to? submethod)
			end
		end
			super
	end
	
	def fermat?
		return false if self < 3
		n = Math.log Math.log(self-1,2),2 
		return n > 0 && n.is_int?
	end
	
	def fermat_pseudoprime?
	
	end
	
	def sophie_germain?
		return (2*(self) + 1).prime?
	end
	
	def safe?
		return ((self - 1)/2).prime?
	end
	
	def chen?
		return (self + 2).prime? || (self + 2).almost_prime?(2)
	end
	
	def mersenne?
		return Math.log(self + 1,2).is_int?
	end
end