class RSA



	def self.Pairs(p,q)
		return false if (p == q ) || p.composite? || q.composite?
		totient = (p*q).totient
		public_keys = Array.new
		1.upto(totient-1){|k| public_keys.push(k) if k.gcd(totient) == 1}
		pairs = Hash.new
		0.upto(public_keys.length - 1) do |i| 
			pairs[public_keys[i]] = public_keys[i].multiplicative_inverse_mod totient
		end
		pairs[:modulus] = p*q
		return pairs
	end

	def self.Crypt(message,key,modulus)
		return message**key % modulus
	end
	
	def self.StringSplit(str,size=4)
		while(str.length % size > 0)
			str +=""
		end
		arr = str.split("")
		while(arr.length > 0)
			0.upto(size -1) do

			end
		end
	end

	attr_accessor :key_public, :key_private, :modulus

	def initialize(p,q)
		pairs = RSA.Pairs(p,q)
		if(pairs)
			index = rand(pairs.size)
			@key_public = pairs.keys[index]
			@key_private = pairs[@key_public]
			@modulus = p*q
		end
	end

	def encrypt(message)
		return RSA.Crypt(message,@key_private,@modulus)
	end

	def decrypt(message)
		return RSA.Crypt(message,@key_public,@modulus)
	end

	def inspect
		return "{Public Key:"+@key_public.to_s+", Modulus: "+@modulus.to_s+"}"
	end
	
	def encrypt_string(message,base=32)
		return message.split("").map {|c| encrypt(c.ord).to_s(base)}.join(" ")
	end

	def decrypt_string(message,base=32)
		return message.split(" ").map {|c| decrypt(c.to_i(base)).chr}.join
	end

end