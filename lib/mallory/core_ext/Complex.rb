class Complex
	#Returns true iff a given number has an imaginary component of 0
	def self.Is_Float?(item)
		return true if item.imaginary == 0
	end

	def inspect
		con = (self.imaginary >=0 )? "+" : "-"
		i = (self.imaginary.abs == 1) ? @@i : self.imaginary.abs.to_s+"*"+@@i;
		return self.real.to_s if  self.imaginary == 0
		return i if self.real == 0 && con == "+"
		return con+i if(self.real == 0 && con == "-")
		return self.real.to_s+con+i;
	end

	def neg
		return Math.Negative(self)
	end

	def recip 
		return Math.Reciprocal(self)
	end

	alias ang arg
	alias mag abs
	
	def to_r
		return real
	end

	def to_i
		return self.real.to_i
	end
 
	def round (place = 0)
		return Complex(real.round(place),imaginary.round(place))
	end
 
	def identity
		return round(@@Precision)
	end
 
	def +@
		return identity
	end
	
	def fraction
		r_frac = real - real.to_i
		i_frac = imaginary - imaginary.to_i
		return Complex(r_frac, i_frac)
	end
	
	def whole
		return(Complex(real.to_i,imaginary.to_i))
	end
	
	#Precision
	@@Precision = 15

	#Representation of i
	@@i="I"
	
	def self.Precision=(precision)
		@@Precision=precision
		puts "Complex.Precision set to " + @@Precision.to_s
		return
	end
	
	def self.Precision
		puts "Complex.Precision set to " + @@Precision.to_s
		return
	end
	
	
	
	@@Ordering = nil
	
	def self.Ordering=(ordering)
		if(ordering == :lex)
			@@Ordering = :lex
			puts "Class:Complex Ordering is Lexigraphical"
		elsif(ordering == :mag)
			@@Ordering = :mag
			puts "Class:Complex Ordering is Magnitudinal"
		elsif(ordering == :ang)
			@@Ordering = :ang
			puts "Class:Complex Ordering is Angular"
		else
			@@Ordering = nil
			puts "The is no Ordering set for the Class:Complex"
		end
		return nil
	end
	
	def self.Ordering
		if(@@Ordering == :lex)
			puts "Class:Complex Ordering is Lexigraphical"
		elsif(@@Ordering == :mag)
			puts "Class:Complex Ordering is Magnitudinal"
		elsif(@@Ordering == :ang)
			puts "Class:Complex Ordering is Angular"
		else
			puts "The is no Ordering set for Class:Complex"
		end
		return nil
	end
	
	
	
	
	

	def old_equals(alpha)
		alpha=Complex(alpha)
		return (self.real == alpha.real && self.imaginary == alpha.imaginary)
	end
	def <=>(alpha)
		if (@@Ordering == nil)
			puts "The is no Ordering set for Class:Complex"
			return nil
		end
			return Math.LexCompare(self,alpha) if(@@Ordering == :lex)
			return Math.MagCompare(self,alpha) if(@@Ordering == :mag)
			return Math.AngCompare(self,alpha) if(@@Ordering == :ang)
	end

	def ==(alpha)
		return self.old_equals(alpha) if(@@Ordering == nil)
		return self.<=>(alpha) == 0
	end
	
	def >(alpha)
		return self.<=>(alpha) == 1
	end
	
	def >=(alpha)
		return self.<=>(alpha) == 1 || self.<=>(alpha) == 0
	end
	
	def <(alpha)
		return self.<=>(alpha) == -1
	end
	
	def <=(alpha)
		return self.<=>(alpha) == -1 || self.<=>(alpha) == 0
	end
	
	def between?(alpha,beta)
		if (@@Ordering == nil)
			puts "The is no Ordering set for Class:Complex"
			return nil
		end
		return self >= alpha && self <= beta
	end
end