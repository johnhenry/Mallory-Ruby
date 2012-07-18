module Math

						#########################
				##################################################
			###########################################################################
	#########################
	######################### PART I: SCALARS
	#########################
			###########################################################################
				##################################################
						#########################
	
	#####
	##########
	###############
	##PART I
	##CHAPTER 0: Constants 
	##
	###############
	##########
	#####
	I = Complex(0,1)
	TAO = 2 * PI
	PHI = 1.6180339887498948482
	ZERO = 0
	ONE = 1
	SQRT2 = sqrt(2)
	INFINITY = Float::INFINITY

	#####
	##########
	###############
	##PART I
	##CHAPTER 1: Unary Functions 
	##
	###############
	##########
	#####

	#Returns true if number is one of ruby's built in numeric types
	def self.Is_Numeric?(item, class_type=Numeric)
		current_class = item.class
		while (current_class != nil)
			return true if (current_class == class_type)
			current_class = current_class.superclass 
		end
		return false
	end

	#Returns the negative or additative inverse of a given number
	def self.Negative(num=0)
		return -num
	end

	def self.Reciprocal(num=1)
		return false if num == 0
		return 1/num
	end
	
	
	#####
	##########
	###############
	##PART I
	##CHAPTER 2: Comparisons Functions
	##These functions help to compare numbers
	###############
	##########
	#####
	
	
	#####
	## Lexigraphical Comparisons
	#####

	def self.LexCompare(alpha,beta=0)
		alpha = Complex(alpha)
		beta = Complex(beta)
		return 1 if (alpha.real > beta.real)
		return -1 if (alpha.real < beta.real)
		return 1 if (alpha.imaginary > beta.imaginary)
		return -1 if (alpha.imaginary < beta.imaginary)
		return 0
	end
	
	def self.LexLessThan?(alpha,beta=0)
		return LexCompare(alpha,beta) == -1
	end
	
	def self.LexGreaterThan?(alpha,beta=0)
		return LexCompare(alpha,beta) == 1
	end
	
	def self.LexEqual?(alpha,beta=0)
		return LexCompare(alpha,beta) == 0
	end

	def self.LexMin(alpha,beta)
		return alpha if (LexLessThan?(alpha,beta))
		return beta
	end
	
	def self.LexMax(alpha,beta)
		return alpha if (LexGreaterThan?(alpha,beta))
		return beta
	end
	
	#####
	## Magnitude Comparisons
	#####
	
	
	def self.MagCompare(alpha,beta=0)
		alpha = Complex(alpha).mag
		beta = Complex(beta).mag
		return 1 if(alpha > beta)
		return -1 if(alpha < beta)
		return 0
	end
	
	def self.MagLessThan?(alpha,beta=0)
		return MagCompare(alpha,beta) == -1
	end
	
	def self.MagGreaterThan?(alpha,beta=0)
		return MagCompare(alpha,beta) == 1
	end
	
	def self.MagEqual?(alpha,beta=0)
		return MagCompare(alpha,beta) == 0
	end

	def self.MagMin(alpha,beta)
		return alpha if (MagLessThan?(alpha,beta))
		return beta
	end
	
	def self.MagMax(alpha,beta)
		return alpha if (MagGreaterThan?(alpha,beta))
		return beta
	end
	
	
	#####
	## Angle Comparisons
	#####
	
	
	def self.AngCompare(alpha,beta=0)
		alpha = Complex(alpha).ang
		beta = Complex(beta).ang
		return 1 if(alpha > beta)
		return -1 if(alpha < beta)
		return 0
	end
	
	def self.AngLessThan?(alpha,beta=0)
		return AngCompare(alpha,beta) == -1
	end
	
	def self.AngGreaterThan?(alpha,beta=0)
		return AngCompare(alpha,beta) == 1
	end
	
	def self.AngEqual?(alpha,beta=0)
		return AngCompare(alpha,beta) == 0
	end

	def self.AngMin(alpha,beta)
		return alpha if (AngLessThan?(alpha,beta))
		return beta
	end
	
	def self.AngMax(alpha,beta)
		return alpha if (AngGreaterThan?(alpha,beta))
		return beta
	end
	
	
	#####
	##########
	###############
	##PART I
	##CHAPTER 3: Exponential and Logarithmic Functions 
	##
	###############
	##########
	#####
		def self.Power(alpha, beta=1, selector=0) 
			alpha = Complex(alpha)
			beta = Complex(beta)
			e = Complex(E,0)
			newPow = beta * self.SelectedNaturalLogarithm(alpha, selector)
			return e**newPow
		end

		def self.Exp(alpha=1)
			return Power(E,alpha)
		end
		
		def self.Powers(alpha,beta=1,limit=10)
			list = Array.new
			0.upto([beta.denominator,limit].min - 1) do |i|
				list.push(self.Power(alpha,beta,i))
			end
			return list
		end

		def self.Square(alpha)
			alpha = Complex(alpha)
			return Power(alpha,2)
		end
		def self.SquareRoot(alpha)
			alpha = Complex(alpha)
			return Power(alpha,0.5)
		end
	
		def self.Logarithm(alpha,base=Math::E,selectA=0,selectB=0)
			return self.SelectedNaturalLogarithm(alpha,selectA) / self.SelectedNaturalLogarithm(base,selectB)
		end
		def self.SelectedNaturalLogarithm(alpha, selector=0)
			return Complex(Math.log(alpha.mag),alpha.ang + 2*Math::PI*selector)
		end
		
		def self.Discrete_Logarithm(alpha,base,n,opp = :multiply)
			0.upto(n-1) {|x| return x if base**x % n == alpha }
			return false
		end
		
	#####
	##########
	###############
	##PART I
	##CHAPTER 4: Trigonometric and Hyperbolic Functions 
	##
	###############
	##########
	#####
	
	##############################
	##Section 0: Helper Functions
	##############################
	
	def self.Sin(a)
		return self.sin(a)
	end
	
	def self.Cos(a)
		return self.cos(a)
	end
	
	def self.Tan(a)
		return self.tan(a)
	end
	
	def self.Sec(a)
		return 1.0/self.cos(a)
	end
	
	def self.Csc(a)
		return 1.0/self.sin(a)
	end
	
	def self.Cot(a)
		return 1.0/self.tan(a)
	end

	def self.HSin(a)
		return ((Math::E**a)- Math::E** (-1*a))/2
	end

	def self.HCos(a)
		return ((Math::E**a)+ Math::E** (-1*a))/2
	end

	def self.HTan(a)
		return self.HSin(a)/self.HCos(a);
	end

	def self.HSec(a)
		return 1.0/self.HCos(a);
	end

	def self.HCsc(a)
		return 1.0/self.HSin(a);
	end

	def self.HCot(a)
		return self.HCos(a)/self.HSin(a)
	end

	##############################
	##Section 4-1-1: Trigonometric Functions
	##############################

	def self.Sine(a)
		a = Complex(a)
		return Complex(self.sin(a.real)*self.HCos(a.imaginary), self.cos(a.real)*self.HSin(a.imaginary))
	end
	
	def self.Cosine(a)
		a = Complex(a)
		return Complex(self.cos(a.real)*self.HCos(a.imaginary), -1*self.sin(a.real)*self.HSin(a.imaginary))
	end
	
	def self.Tangent(a)
		return self.Sine(a)/self.Cosine(a)
	end
	
	def self.Secant(a)
		return 1.0/self.Cosine(a)
	end
	
	def self.Cosecant(a)
		return 1.0/self.Sine(a)
	end
	
	def self.Cotangent(a)
		return self.Cosine(a)/self.Sine(a)
	end
	
	##############################
	##Section 4-1-2: Inverse Trigonometric Functions
	##############################
	
	def self.ArcSine(a)
		a = Complex(a);
		return (-Math::I)*(self.Logarithm((Math::I*a)+self.SquareRoot(1 - self.Square(a))))
	end
	
	def self.ArcCosine(a)
		a = Complex(a);
		return Math::PI/2 - ArcSine(a)
	end

	def self.ArcTangent(a)
		a = Complex(a);
		return (Math::I/2)*(self.Logarithm(1 - I*a)-self.Logarithm(1+I*a))
	end
	
	def self.ArcSecant(a)
		a=Complex(a)
		return self.ArcCosine(1.0/a)
	end
	
	def self.ArcCosecant(a)
		a=Complex(a)
		return self.ArcSine(1.0/a)
	end
	
	def self.ArcCotangent(a)
		a=Complex(a)
		return self.ArcTangent(1.0/a)
	end
	
	##############################
	##Section 4-2-1: Hyperbolic Functions
	##Reference: http://en.wikipedia.org/wiki/Arc_functions
	##############################

	def self.HyperbolicSine(a)
		a = Complex(a)
		return Complex(self.HSin(a.real)*Math.cos(a.imaginary), self.HCos(a.real)*Math.sin(a.imaginary))
	end
	
	def self.HyperbolicCosine(a)
		a = Complex(a)
		return Complex(self.HCos(a.real)*Math.cos(a.imaginary), self.HSin(a.real)*Math.sin(a.imaginary))
	end
	
	
	def self.HyperbolicTangent(a)
		return self.HyperbolicSine(a)/self.HyperbolicCosine(a)
	end
	
	def self.HyperbolicSecant(a)
		return 1.0/self.HyperbolicCosine(a)
	end
	
	def self.HyperbolicCosecant(a)
		return 1.0/self.HyperbolicSine(a)
	end
	
	def self.HyperbolicCotangent(a)
		return self.HyperbolicCosine(a)/self.HyperbolicSine(a)
	end

	##############################
	##Section 4-2-2: Inverse Hyperbolic Functions
	##Reference: http://en.wikipedia.org/wiki/Inverse_hyperbolic_function
	##############################
	
	def self.ArcHyperbolicSine(a)
		return self.Logarithm(a+self.SquareRoot(self.Square(a) + 1))
	end
	
	def self.ArcHyperbolicCosine(a)
		return self.Logarithm(a+self.SquareRoot(self.Square(a) - 1))
	end
	
	def self.ArcHyperbolicTangent(a)
		return 1.0/2 * self.Logarithm((1+a)/(1-a));
	end
	
	def self.ArcHyperbolicCotangent(a)
		return 1.0/2 * self.Logarithm((a+1)/(a-1));
	end
	
	def self.ArcHyperbolicSecant(a)
		return self.Logarithm( (1.0/a) + self.SquareRoot(self.Square(1.0/a) - 1))
	end
	
	def self.ArcHyperbolicCotangent(a)
		return self.Logarithm( (1.0/a) + self.SquareRoot(self.Square(1.0/a) + 1))
	end
	
	#####
	##########
	###############
	##PART I
	##CHAPTER 5: Lambda Functions
	##These are functions that take other functions as arguments
	###############
	##########
	#####
	
	def self.VerFunction(fun)
		return ->(a){2*fun.call(a/2)**2} 
	end
	
	def self.CoFunction(fun)
		return ->(a){2*fun.call(Math::PI/2 - a)} 
	end

	def self.HaFunction(fun)
		return ->(a){fun.call(a)/2} 
	end
	
	def self.ExFunction(fun)
		return ->(a){fun.call(a) -1} 
	end
	
	def self.Summation(beginning,ending,operation)
		return (beginning..ending).to_array.map{|x| operation.call(x)}.element_sum
	end	
	def self.Product(beginning,ending,operation)
		return (beginning..ending).to_array.map{|x| operation.call(x)}.element_product
	end
	
	def self.Solve_Numerically(operation,target=0,accuracy=0.01,guess=0,limit=100)
		diff = operation.call(guess) - target
		if(!Math.MagGreaterThan?(diff,accuracy))
			return guess
		end
		return guess if (limit == 0)
		guess = guess - diff
		return Solve_Numerically(operation,target,accuracy,guess,limit-1)
	end
	
	def self.Integrate_Numerically(operation,lower=0,upper=1,interval=0.01)
		result = 0
		while (lower < upper)
			b1 = operation.call(lower)
			b2 = operation.call(lower+interval)
			h = interval
			result += (b1+b2)*h/2
			lower += interval 
		end
		return result
	end
	
	def self.Differentiate_Numerically(operation,point=0,limit=0.01)
		return (operation.call(point+limit) - operation.call(point))/limit
	end
	
	def self.Iterate_Binary(f,a,b=1)
		result = a
		while (b > 1)
			result = f.call(a,result)
			b -= 1
		end
		return result
	end

	def self.Hyper_Operation(a,b=0,n=0)
		return b + 1 if(n < 1)
		return Iterate_Binary(->(a,b){Hyper_Operation(a,b,n-1)},a,b)
	end
	
	def self.Knuth(a,b=1,n=1)
		return Power(a, b) if n < 2
		return Iterate_Binary(->(a,b){Knuth(a,b,n-1)},a,b)
	end
	
	def self.Ackermann(a,b=0,n=0)
		return a + b if(n < 1)
		return Iterate_Binary(->(a,b){Ackermann(a,b,n-1)},a,b)
	end
	
	def self.Ackermann_Peter(m,n)
		return n + 1 if(m == 0)
		return Ackermann_Peter(m-1,1) if(m >0 && n == 0)
		return Ackermann_Peter(m-1,Ackermann_Peter(m,n-1)) if (m > 0 && n > 0)
		return nil
	end
	
	def self.Iterate_Function(f,seed,n=0)
		return seed if n == 0
		return f.call(Iterate_Function(f,seed,n-1))
	end
	
	
	#####
	##########
	###############
	##PART I
	##CHAPTER 6: Probability
	##
	###############
	##########
	#####
	

	
	def self.Normal_Distribution(mean,sdev)
		return ->(x){1.0/(((s_dev*Math.sqrt(2*Math::PI))*(Math::E**(-0.5 *(x.z_score(mean,s_dev))**2))))}
	end
	
	def self.Standard_Normal_Distribution(x = 0)
		return self.Normal_Distribution(0,1).call(x)
	end
	

	
end