class Numeric
	def to_radians
		return self*Math::PI/180
	end
	
	def to_degrees
		return self*180.0/Math::PI
	end
	
	def to_percent_string
		return (self*100).to_s+"%"
	end
	
	def in_pi
		return in_rational_terms(Math::PI)
	end
	
	def in_rational_terms(terms_of)
		k = self/terms_of
		return Rational(k.numerator,k.denominator)
	end
	
	def fraction
		return self - self.to_int
	end
	
	def is_int?
		return Integer(self) == self
	end
	
	def divides?(n)
		return (n.to_f/self).is_int? if self.is_int?
		return (n/self).is_int?
	end
	
	def z_score(mean = 0,sdev =1)
		return (self - mean)/sdev
	end
	
	def invert_z_score(mean=0,dev=1)
		return (self*sdev)+mean
	end
	
	def normal_probability(mean=0,sdev=1,neg_infinity=-5,interval=0.001)
		return Math.Integrate_Numerically(->(x){Math.Normal_Distribution(mean,sdev)},neg_infinity,self,interval)
	end
	
	def standard_normal_probabillity(neg_infinity=-5,interval=0.001)
		return Math.Integrate_Numerically(->(x){Math.Math.Standard_Normal_Distribution.call(x)},neg_infinity,self,interval)
	end
	
	alias whole to_int
end